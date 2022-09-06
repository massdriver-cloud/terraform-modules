variable "container_image" {
  type = string
}

variable "max_instances" {
  type    = number
  default = 5
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
