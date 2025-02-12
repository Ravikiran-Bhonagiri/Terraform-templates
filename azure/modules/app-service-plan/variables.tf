
variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "app_name" {
  description = "Application name (3-40 characters)"
  type        = string
}

variable "environment" {
  description = "Environment name (prod/staging/dev)"
  type        = string
}

variable "os_type" {
  description = "Operating system type (windows/linux)"
  type        = string
  default     = "linux"
  validation {
    condition     = contains(["linux", "windows"], var.os_type)
    error_message = "OS type must be 'linux' or 'windows'"
  }
}

variable "sku_tier" {
  description = "Pricing tier (PremiumV3, PremiumV2, Standard, etc.)"
  type        = string
  default     = "PremiumV3"
}

variable "sku_size" {
  description = "Instance size (P1v3, P2v3, etc.)"
  type        = string
  default     = "P1v3"
}

variable "min_capacity" {
  description = "Minimum number of instances"
  type        = number
  default     = 2
}

variable "max_capacity" {
  description = "Maximum number of instances"
  type        = number
  default     = 10
}

variable "zone_redundant" {
  description = "Enable zone redundancy (PremiumV3 only)"
  type        = bool
  default     = true
}

variable "per_site_scaling" {
  description = "Enable per-app scaling"
  type        = bool
  default     = false
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID for diagnostics"
  type        = string
}

variable "enable_private_endpoint" {
  description = "Enable private endpoint connection"
  type        = bool
  default     = true
}

variable "private_endpoint_subnet_id" {
  description = "Subnet ID for private endpoint"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}
