resource "azurerm_app_service" "main" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = var.app_service_plan_id
  https_only          = true

  # Required for production
  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on        = var.always_on
    min_tls_version  = "1.2"
    ftps_state       = "Disabled"
    http2_enabled    = true
    scm_type         = "VSTSRM" # Azure DevOps integration

    # Platform configuration
    linux_fx_version   = var.linux_fx_version
    windows_fx_version = var.windows_fx_version
    
    # IP restrictions
    dynamic "ip_restriction" {
      for_each = var.ip_restrictions
      content {
        ip_address                = ip_restriction.value.ip_address
        service_tag               = ip_restriction.value.service_tag
        virtual_network_subnet_id = ip_restriction.value.virtual_network_subnet_id
        name                      = ip_restriction.value.name
        priority                  = ip_restriction.value.priority
      }
    }

    # Virtual network integration
    vnet_route_all_enabled = var.vnet_integration_enabled
  }

  # Application settings
  app_settings = merge({
    "APPINSIGHTS_INSTRUMENTATIONKEY" = var.application_insights_key
    "WEBSITE_HEALTHCHECK_MAXPINGFAILURES" = "10"
  }, var.app_settings)

  # Connection strings
  dynamic "connection_string" {
    for_each = var.connection_strings
    content {
      name  = connection_string.key
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }

  tags = merge(var.tags, {
    environment = var.environment
  })

  lifecycle {
    ignore_changes = [
      site_config[0].scm_type,
      tags["last_modified"]
    ]
  }
}
