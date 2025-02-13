# Required Variables

variable "function_app_name" {
  description = "(Required) The name of the Azure Function App. This must be globally unique."
  type        = string
  validation {
    condition     = length(var.function_app_name) >= 2 && length(var.function_app_name) <= 60
    error_message = "The Function App name must be between 2 and 60 characters long."
  }
}

variable "location" {
  description = "(Required) The Azure region where the Function App will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The name of the existing resource group where the Function App will be deployed."
  type        = string
}

variable "app_service_plan_id" {
  description = "(Required) The ID of the existing App Service Plan to be used by the Function App."
  type        = string
}

variable "storage_account_name" {
  description = "(Required) The name of the existing storage account to be used by the Function App."
  type        = string
}

variable "storage_account_access_key" {
  description = "(Required) The access key of the existing storage account. This should be marked as sensitive."
  type        = string
  sensitive   = true
}

# Optional Variables

variable "function_app_version" {
  description = "(Optional) The version of the Function App runtime. Defaults to '~4'."
  type        = string
  default     = "~4"
  validation {
    condition     = contains(["~3", "~4"], var.function_app_version)
    error_message = "The Function App version must be either '~3' or '~4'."
  }
}

variable "function_app_runtime" {
  description = "(Optional) The runtime stack for the Function App (e.g., 'node', 'python', 'dotnet'). Defaults to 'node'."
  type        = string
  default     = "node"
  validation {
    condition     = contains(["node", "python", "dotnet"], var.function_app_runtime)
    error_message = "The Function App runtime must be one of 'node', 'python', or 'dotnet'."
  }
}

variable "always_on" {
  description = "(Optional) Whether the Function App should be always on. Defaults to 'true'."
  type        = bool
  default     = true
}

variable "app_settings" {
  description = "(Optional) A map of key-value pairs for Function App settings."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "(Optional) A map of tags to apply to the Function App."
  type        = map(string)
  default     = {}
}
