output "function_app_name" {
  value = azurerm_linux_function_app.main.name
}

output "function_app_id" {
  value = azurerm_linux_function_app.main.id
}

output "storage_account_name" {
  value = azurerm_storage_account.function.name
}

output "service_plan_id" {
  value = azurerm_service_plan.main.id
}
