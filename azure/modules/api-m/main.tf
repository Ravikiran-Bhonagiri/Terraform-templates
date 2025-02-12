resource "azurerm_api_management" "main" {
  name                = local.apim_name
  location            = var.location
  resource_group_name = var.resource_group_name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email

  sku_name = "${var.sku_tier}_${var.sku_capacity}"

  # Identity Configuration
  identity {
    type = "SystemAssigned"
  }

  # Virtual Network Configuration
  virtual_network_type = var.virtual_network_type
  virtual_network_configuration {
    subnet_id = var.subnet_id
  }

  # Security
  client_certificate_enabled = var.client_certificate_enabled
  protocols {
    enable_http2 = var.enable_http2
  }

  # Custom Domains
  dynamic "hostname_configuration" {
    for_each = var.custom_domains
    content {
      host_name                    = hostname_configuration.value.host_name
      key_vault_id                 = hostname_configuration.value.key_vault_secret_id
      negotiate_client_certificate = hostname_configuration.value.negotiate_client_cert
    }
  }

  # Monitoring
  dynamic "diagnostics" {
    for_each = var.diagnostic_settings
    content {
      name               = diagnostics.key
      log_analytics_workspace_id = diagnostics.value.log_analytics_workspace_id
      storage_account_id = diagnostics.value.storage_account_id
      eventhub_name      = diagnostics.value.eventhub_name
      eventhub_authorization_rule_id = diagnostics.value.eventhub_auth_rule_id
    }
  }

  tags = merge(var.tags, {
    environment = var.environment
    managedBy   = "terraform"
  })

  lifecycle {
    ignore_changes = [certificate]
  }
}

# API Management Logging to Application Insights
resource "azurerm_api_management_logger" "main" {
  count = var.enable_application_insights ? 1 : 0

  name                = "appinsights-logger"
  api_management_name = azurerm_api_management.main.name
  resource_group_name = var.resource_group_name

  application_insights {
    instrumentation_key = var.application_insights_instrumentation_key
  }
}

# Private Endpoint Configuration
resource "azurerm_private_endpoint" "apim" {
  count = var.enable_private_endpoint ? 1 : 0

  name                = "${local.apim_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${local.apim_name}-psc"
    private_connection_resource_id = azurerm_api_management.main.id
    is_manual_connection           = false
    subresource_names              = ["gateway"]
  }

  dynamic "private_dns_zone_group" {
    for_each = var.private_dns_zone_id != "" ? [1] : []
    content {
      name                 = "default"
      private_dns_zone_ids = [var.private_dns_zone_id]
    }
  }
}

# API Policies
resource "azurerm_api_management_api_policy" "main" {
  for_each = var.api_policies

  api_name            = each.value.api_name
  api_management_name = azurerm_api_management.main.name
  resource_group_name = var.resource_group_name

  xml_content = file(each.value.policy_file_path)
}
