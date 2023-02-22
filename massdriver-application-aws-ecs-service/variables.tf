variable "md_metadata" {
  description = "Massdriver metadata block"
  type        = any
}

variable "ecs_cluster" {
  description = "Massdriver ECS Cluster Artifact"
  type        = any
}

variable "launch_type" {
  description = "Launch type on which to run your service. The valid values are `EC2` and `FARGATE`. Default is `EC2`"
  type        = string
  default     = "EC2"

  validation {
    condition     = contains(["EC2", "FARGATE"], var.launch_type)
    error_message = "Allowed values for launch_type are \"EC2\" and \"FARGATE\""
  }
}

variable "task_cpu" {
  description = "Task CPU resources"
  type        = number
}

variable "task_memory" {
  description = "Task Memory resources"
  type        = number
}

variable "logging" {
  description = "Logging configuration"
  type = object({
    driver    = string
    retention = optional(number)
  })

  default = {
    driver = "disabled"
  }

  validation {
    condition     = contains(["disabled", "awslogs"], var.logging.driver)
    error_message = "Allowed values for logging.driver are \"disabled\" and \"awslogs\""
  }
}

variable "autoscaling" {
  description = "Autoscaling Configuration"
  type = object({
    min_replicas       = number
    max_replicas       = number
    target_cpu_percent = number
  })
}

variable "containers" {
  description = "Container"
  type = list(object({
    name             = string
    image_repository = string
    image_tag        = string
    cpu              = optional(number)
    memory           = optional(number)
    command          = optional(list(string))
    arguments        = optional(list(string))
    ports = list(object({
      container_port = number
      ingresses = list(object({
        hostname = string
        path     = string
      }))
    }))
  }))
}
