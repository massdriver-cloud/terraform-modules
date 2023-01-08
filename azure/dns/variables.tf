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

variable "azurerm_linux_function_app" {
  type    = any
  default = null
}

variable "azurerm_linux_web_app" {
  type    = any
  default = null
}
