resource "azurerm_function_app" "fa" {
  name                       = var.function_app_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = var.app_service_plan_id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  version                    = var.function_app_version

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = var.function_app_runtime
  }

  site_config {
    always_on = var.always_on
  }

  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_RUN_FROM_PACKAGE"],
    ]
  }
}
