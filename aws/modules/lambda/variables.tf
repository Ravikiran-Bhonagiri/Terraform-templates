variable "function_name" {
  description = "The name of the Lambda function."
  type        = string
}

variable "handler" {
  description = "The function entrypoint in your code."
  type        = string
}

variable "runtime" {
  description = "The runtime environment for the Lambda function."
  type        = string
  default     = "python3.9"
}

variable "source_path" {
  description = "The path to the source code or deployment package."
  type        = string
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda function can use."
  type        = number
  default     = 128
}

variable "timeout" {
  description = "The amount of time your Lambda function has to run in seconds."
  type        = number
  default     = 3
}

variable "environment_variables" {
  description = "A map of environment variables to pass to the Lambda function."
  type        = map(string)
  default     = {}
}

variable "layers" {
  description = "List of Lambda layer ARNs to attach to the function."
  type        = list(string)
  default     = []
}

variable "reserved_concurrent_executions" {
  description = "The number of concurrent executions reserved for the Lambda function."
  type        = number
  default     = -1
}

variable "publish" {
  description = "Whether to publish a version of the Lambda function."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the Lambda function."
  type        = map(string)
  default     = {}
}
