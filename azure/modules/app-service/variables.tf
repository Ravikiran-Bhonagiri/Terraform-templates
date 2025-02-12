# modules/app-service/variables.tf
variable "name" {
  description = "Name of the App Service"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "app_service_plan_id" {
  description = "ID of the App Service Plan"
  type        = string
}

variable "environment" {
  description = "Environment tag (prod/staging/dev)"
  type        = string
  default     = "prod"
}

variable "always_on" {
  description = "Keep the app loaded in memory"
  type        = bool
  default     = true
}

variable "linux_fx_version" {
  description = "Linux runtime stack (e.g., 'DOCKER|nginx:latest')"
  type        = string
  default     = null
}

variable "windows_fx_version" {
  description = "Windows runtime stack (e.g., 'DOTNETCORE|6.0')"
  type        = string
  default     = null
}

variable "ip_restrictions" {
  description = "List of IP restriction rules"
  type = list(object({
    ip_address                = optional(string)
    service_tag               = optional(string)
    virtual_network_subnet_id = optional(string)
    name                      = string
    priority                  = number
  }))
  default = []
}

variable "vnet_integration_enabled" {
  description = "Enable VNet integration"
  type        = bool
  default     = false
}

variable "app_settings" {
  description = "Application settings"
  type        = map(string)
  default     = {}
}

variable "connection_strings" {
  description = "Connection strings"
  type = map(object({
    type  = string
    value = string
  }))
  default = {}
}

variable "application_insights_key" {
  description = "Application Insights instrumentation key"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
