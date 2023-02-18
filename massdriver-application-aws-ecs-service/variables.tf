variable "md_metadata" {
  description = "Massdriver metadata block"
  type        = any
}

variable "ecs_cluster" {
  description = "Massdriver ECS Cluster Artifact"
  type        = any
}

variable "containers" {
  description = "Container"
  type = list(object({
    name             = string
    image_repository = string
    image_tag        = string
    cpu              = number
    memory           = number
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
