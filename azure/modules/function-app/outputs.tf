output "function_app_id" {
  description = "The ID of the Azure Function App."
  value       = azurerm_function_app.fa.id
}

output "function_app_name" {
  description = "The name of the Azure Function App."
  value       = azurerm_function_app.fa.name
}

output "function_app_default_hostname" {
  description = "The default hostname of the Azure Function App."
  value       = azurerm_function_app.fa.default_hostname
}

output "function_app_outbound_ip_addresses" {
  description = "The outbound IP addresses of the Azure Function App."
  value       = azurerm_function_app.fa.outbound_ip_addresses
}

output "function_app_connection_string" {
  description = "The connection string of the Azure Function App."
  value       = azurerm_function_app.fa.connection_string
  sensitive   = true
}

output "function_app_principal_id" {
  description = "The Principal ID of the Azure Function App's managed identity (if enabled)."
  value       = azurerm_function_app.fa.identity[0].principal_id
}

output "function_app_tenant_id" {
  description = "The Tenant ID of the Azure Function App's managed identity (if enabled)."
  value       = azurerm_function_app.fa.identity[0].tenant_id
}

output "function_app_site_credentials" {
  description = "The site credentials (username and password) for the Azure Function App."
  value       = azurerm_function_app.fa.site_credential
  sensitive   = true
}
