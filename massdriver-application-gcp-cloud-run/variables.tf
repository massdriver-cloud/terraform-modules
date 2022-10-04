variable "md_metadata" {
  type        = any
  description = "Massdriver metadata which is provided by the Massdriver deployment runtime"
}

variable "container_image" {
  type = string
}

variable "max_instances" {
  type = number
}

variable "location" {
  type = string
}

variable "endpoint" {
  type = any
}

variable "vpc_connector" {
  type = string
}
