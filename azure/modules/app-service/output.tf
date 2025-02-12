
output "id" {
  description = "App Service ID"
  value       = azurerm_app_service.main.id
}

output "name" {
  description = "App Service name"
  value       = azurerm_app_service.main.name
}

output "default_hostname" {
  description = "Default hostname"
  value       = azurerm_app_service.main.default_hostname
}

output "outbound_ip_addresses" {
  description = "Outbound IP addresses"
  value       = azurerm_app_service.main.outbound_ip_addresses
}

output "principal_id" {
  description = "Managed Identity Principal ID"
  value       = azurerm_app_service.main.identity[0].principal_id
}

output "possible_outbound_ip_addresses" {
  description = "All possible outbound IPs"
  value       = azurerm_app_service.main.possible_outbound_ip_addresses
}
