variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "app_name" {
  type        = string
  description = "Application name"
}

variable "environment" {
  type        = string
  description = "Environment (dev, staging, prod)"
}

variable "location_short" {
  type        = string
  description = "Short form of Azure region"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}

variable "storage_replication_type" {
  type        = string
  description = "Storage account replication type"
  default     = "GRS"
}

variable "storage_public_access_enabled" {
  type        = bool
  description = "Enable public network access for storage"
  default     = false
}

variable "service_plan_sku" {
  type        = string
  description = "App Service Plan SKU"
  default     = "EP1"
}

variable "always_on" {
  type        = bool
  description = "Enable Always On feature"
  default     = true
}

variable "app_scale_limit" {
  type        = number
  description = "Maximum number of workers"
  default     = 10
}

variable "runtime_version" {
  type        = string
  description = "Function runtime version"
  default     = "6.0"
}

variable "runtime_stack" {
  type        = string
  description = "Function runtime stack"
  default     = "dotnet"
}

variable "app_settings" {
  type        = map(string)
  description = "Additional application settings"
  default     = {}
}
