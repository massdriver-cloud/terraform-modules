variable "md_metadata" {
  type        = any
  description = "Massdriver metadata which is provided by the Massdriver deployment runtime"
}

variable "container_image" {
  type = string
}

variable "port" {
  type = number
}

variable "max_instances" {
  type = number
}

variable "location" {
  type = string
}

variable "subnetwork" {
  type = any
}

variable "endpoint" {
  type = any
}

variable "machine_type" {
  type = string
}

variable "spot_instances_enabled" {
  type    = bool
  default = false
}

variable "compute_image_family" {
  type    = string
  default = "cos-101-lts"

  validation {
    condition     = contains(["cos-101-lts", "common-cu110"], var.compute_image_family)
    error_message = "Allowed values for compute_image_family are \"cos-101-lts\", or \"common-cu110\"."
  }
}

variable "health_check" {
  type = object({
    port = optional(number, 80)
    path = optional(string, "/health")
  })
}
