resource "azurerm_storage_account" "function" {
  name                     = "st${replace(var.app_name, "-", "")}${var.environment}${var.location_short}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = var.storage_replication_type
  min_tls_version          = "TLS1_2"

  enable_https_traffic_only     = true
  public_network_access_enabled = var.storage_public_access_enabled

  tags = merge(var.tags, { Component = "Storage" })
}

resource "azurerm_service_plan" "main" {
  name                = "asp-${var.app_name}-${var.environment}-${var.location_short}"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.service_plan_sku
  tags                = merge(var.tags, { Component = "App-Service-Plan" })
}

resource "azurerm_linux_function_app" "main" {
  name                = "func-${var.app_name}-${var.environment}-${var.location_short}"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.main.id
  tags                = merge(var.tags, { Component = "Function-App" })

  storage_account_name       = azurerm_storage_account.function.name
  storage_account_access_key = azurerm_storage_account.function.primary_access_key

  site_config {
    always_on        = var.always_on
    ftps_state       = "Disabled"
    app_scale_limit  = var.app_scale_limit
    runtime_scale_monitoring_enabled = true

    application_stack {
      dotnet_version = var.runtime_version
    }
  }

  app_settings = merge({
    "WEBSITE_RUN_FROM_PACKAGE"    = "1"
    "WEBSITE_CONTENTOVERVNET"     = "1"
    "FUNCTIONS_WORKER_RUNTIME"    = var.runtime_stack
  }, var.app_settings)

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_RUN_FROM_PACKAGE"],
    ]
  }
}
