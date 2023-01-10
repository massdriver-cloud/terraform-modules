variable "subdomain" {
  type = string
}

variable "tags" {
  type = any
}

variable "zone_name" {
  type = string
}

variable "zone_resource_group_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "function_app" {
  type    = any
  default = null
}

variable "app_service" {
  type    = any
  default = null
}
