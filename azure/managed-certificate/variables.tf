variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "full_domain" {
  type = string
}

variable "dns_zone_resource_group_name" {
  type = string
}

variable "identity" {
  type = any
}
