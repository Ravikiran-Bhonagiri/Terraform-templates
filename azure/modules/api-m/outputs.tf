output "apim_id" {
  description = "ID of the API Management service"
  value       = azurerm_api_management.main.id
}

output "gateway_url" {
  description = "URL of the API Management Gateway"
  value       = azurerm_api_management.main.gateway_url
}

output "management_api_url" {
  description = "URL of the API Management Management API"
  value       = azurerm_api_management.main.management_api_url
}

output "portal_url" {
  description = "URL of the Developer Portal"
  value       = azurerm_api_management.main.portal_url
}

output "public_ip_addresses" {
  description = "Public IP addresses of the API Management service"
  value       = azurerm_api_management.main.public_ip_addresses
}

output "private_ip_addresses" {
  description = "Private IP addresses of the API Management service"
  value       = azurerm_api_management.main.private_ip_addresses
}

output "identity_principal_id" {
  description = "Principal ID of the system-assigned identity"
  value       = azurerm_api_management.main.identity[0].principal_id
}
