variable "resource_group_name" {
  description = "The name of the resource group in which to create the API Management service"
  type        = string
}

variable "location" {
  description = "Azure region where the resource will be created"
  type        = string
}

variable "environment" {
  description = "Environment tag (e.g., prod, staging, dev)"
  type        = string
}

variable "sku_tier" {
  description = "SKU tier for API Management (Developer, Basic, Standard, Premium)"
  type        = string
  default     = "Premium"
}

variable "sku_capacity" {
  description = "Number of scale units for the API Management service"
  type        = number
  default     = 1
}

variable "publisher_name" {
  description = "Name of the publisher/organization"
  type        = string
}

variable "publisher_email" {
  description = "Email address of the publisher"
  type        = string
}

variable "enable_private_endpoint" {
  description = "Enable private endpoint for API Management"
  type        = bool
  default     = true
}

variable "private_endpoint_subnet_id" {
  description = "Subnet ID for private endpoint"
  type        = string
  default     = ""
}

variable "private_dns_zone_id" {
  description = "Private DNS Zone ID for private endpoint"
  type        = string
  default     = ""
}

variable "custom_domains" {
  description = "List of custom domains with SSL certificates from Key Vault"
  type = list(object({
    host_name            = string
    key_vault_secret_id  = string
    negotiate_client_cert = bool
  }))
  default = []
}

variable "enable_application_insights" {
  description = "Enable Application Insights integration"
  type        = bool
  default     = true
}

variable "application_insights_instrumentation_key" {
  description = "Application Insights instrumentation key"
  type        = string
  default     = ""
}

variable "client_certificate_enabled" {
  description = "Enable client certificate verification"
  type        = bool
  default     = true
}

variable "enable_http2" {
  description = "Enable HTTP/2 protocol support"
  type        = bool
  default     = true
}

variable "virtual_network_type" {
  description = "Type of virtual network integration (None, External, Internal)"
  type        = string
  default     = "Internal"
}

variable "subnet_id" {
  description = "Subnet ID for virtual network integration"
  type        = string
  default     = ""
}

variable "api_policies" {
  description = "Map of API policies to apply"
  type = map(object({
    api_name         = string
    policy_file_path = string
  }))
  default = {}
}

variable "tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}
