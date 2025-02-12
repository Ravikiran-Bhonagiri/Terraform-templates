
output "id" {
  description = "App Service Plan ID"
  value       = azurerm_app_service_plan.main.id
}

output "name" {
  description = "App Service Plan name"
  value       = azurerm_app_service_plan.main.name
}

output "kind" {
  description = "Plan kind (Windows/Linux)"
  value       = azurerm_app_service_plan.main.kind
}

output "sku" {
  description = "SKU details"
  value       = azurerm_app_service_plan.main.sku
}

output "outbound_ip_addresses" {
  description = "Outbound IP addresses"
  value       = azurerm_app_service_plan.main.outbound_ip_addresses
}

output "private_endpoint_ip" {
  description = "Private endpoint IP address if enabled"
  value       = try(azurerm_private_endpoint.main[0].private_service_connection[0].private_ip_address, null)
}
