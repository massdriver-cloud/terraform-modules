variable "name" {
  type = string
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

variable "network" {
  type = string
}

variable "endpoint" {
  type = any
}

variable "vpc_connector_cidr" {
  type    = string
  default = null
}
