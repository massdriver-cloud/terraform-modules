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

variable "zone" {
  type    = string
  default = null
}

variable "subdomain" {
  type    = string
  default = null
}

variable "vpc_connector_cidr" {
  type    = string
  default = null
}
