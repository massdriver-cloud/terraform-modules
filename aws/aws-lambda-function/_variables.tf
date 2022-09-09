variable "function_name" {
  type        = string
  description = "Name for the lambda function"
}

variable "envs" {
  type        = any
  description = "Environment variables to be added to the lambda runtime"
}

variable "role_arn" {
  type        = string
  description = "Role ARN to be used as the identity for the workload"
}

variable "image" {
  type = object({
    uri = string
    tag = string
  })
  description = "Docker image URI and tag"
}

variable "x_ray_enabled" {
  type        = bool
  default     = false
  description = "Enable AWS native tracing via X-Ray"
}

variable "retention_days" {
  type        = number
  default     = 7
  description = "Retention time for execution logs in days"
}

variable "memory_size" {
  type        = number
  default     = 128
  description = "Upper limit of memory in MB"
}

variable "execution_timeout" {
  type        = number
  default     = 3
  description = "Timeout period in seconds"
}
