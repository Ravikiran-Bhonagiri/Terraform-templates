variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1" # Change to your desired default region
}

variable "api_name" {
  description = "Name of the API Gateway REST API"
  type        = string
  default     = "production-api"
}

variable "stage_name" {
  description = "Name of the deployment stage"
  type        = string
  default     = "prod" # Production stage name
}

variable "backend_url" {
  description = "URL of the backend service to integrate with (HTTP Proxy)"
  type        = string
  default     = "https://httpbin.org/get" # Example backend URL, replace with your actual backend
}

variable "domain_name" {
  description = "(Optional) Custom domain name for the API Gateway"
  type        = string
  default     = "" # Leave empty if not using a custom domain
}

variable "acm_certificate_arn" {
  description = "(Optional, Required if domain_name is provided) ARN of the ACM certificate for the custom domain"
  type        = string
  default     = "" # Leave empty if not using a custom domain
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    Environment = "Production"
    Project     = "API"
    ManagedBy   = "Terraform"
  }
}
