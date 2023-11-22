variable "md_metadata" {
  type        = any
  description = "Massdriver metadata which is provided by the Massdriver deployment runtime"
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
