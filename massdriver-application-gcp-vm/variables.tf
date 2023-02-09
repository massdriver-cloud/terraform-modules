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

variable "health_check" {
  type = object({
    port = number
    path = string
  })
}
