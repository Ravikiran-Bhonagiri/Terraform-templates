variable "bucket_name" {
  description = "The name of the S3 bucket. Must be globally unique."
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, staging, prod)."
  type        = string
}

variable "versioning_enabled" {
  description = "Enable versioning for the S3 bucket."
  type        = bool
  default     = true
}

variable "enable_server_side_encryption" {
  description = "Enable server-side encryption for the S3 bucket."
  type        = bool
  default     = true
}

variable "lifecycle_rules" {
  description = "List of lifecycle rules for the S3 bucket."
  type = list(object({
    id      = string
    enabled = bool
    prefix  = string
    transition = list(object({
      days          = number
      storage_class = string
    }))
    expiration = list(object({
      days = number
    }))
  }))
  default = []
}
