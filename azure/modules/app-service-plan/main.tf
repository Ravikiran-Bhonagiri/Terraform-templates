resource "azurerm_app_service_plan" "main" {
  name                = "asp-${var.app_name}-${var.environment}-${var.location}"
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = var.os_type == "linux" ? "Linux" : "Windows"
  reserved            = var.os_type == "linux" # Must be true for Linux plans

  sku {
    tier = var.sku_tier
    size = var.sku_size
    capacity = var.min_capacity
  }

  per_site_scaling    = var.per_site_scaling
  zone_redundant      = var.zone_redundant

  tags = merge(var.tags, {
    environment = var.environment
    workload    = var.app_name
  })
}

# Auto-scaling Configuration
resource "azurerm_monitor_autoscale_setting" "main" {
  name                = "autoscale-${var.app_name}-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  target_resource_id  = azurerm_app_service_plan.main.id

  profile {
    name = "default"

    capacity {
      default = var.min_capacity
      minimum = var.min_capacity
      maximum = var.max_capacity
    }

    # Scale Out Rule
    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_app_service_plan.main.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 70
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }

    # Scale In Rule
    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_app_service_plan.main.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 30
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT10M"
      }
    }
  }
}

# Diagnostic Settings
resource "azurerm_monitor_diagnostic_setting" "main" {
  name                       = "diag-${var.app_name}-${var.environment}"
  target_resource_id         = azurerm_app_service_plan.main.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "AppServicePlatformLogs"
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}

# Private Endpoint (Optional)
resource "azurerm_private_endpoint" "main" {
  count               = var.enable_private_endpoint ? 1 : 0
  name                = "pe-asp-${var.app_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "psc-asp-${var.app_name}"
    private_connection_resource_id = azurerm_app_service_plan.main.id
    is_manual_connection           = false
    subresource_names              = ["serverFarms"]
  }
}
