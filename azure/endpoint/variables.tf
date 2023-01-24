variable "name" {
  type = string
}

variable "domain" {
  type = string
}

variable "subdomain" {
  type = string
}

variable "tags" {
  type = any
}

variable "resource_group_name" {
  type = string
}

variable "dns_zone_name" {
  type = string
}

variable "dns_zone_resource_group_name" {
  type = string
}

variable "port" {
  type    = number
  default = 80
}

variable "health_check" {
  type = object({
    path = optional(string, "/")
    port = optional(number, 80)
  })
  default = {
    path = "/"
    port = 80
  }
}

variable "subnet_id" {
  type = string
}

variable "user_assigned_identity_principal_id" {
  type = string
}

variable "user_assigned_identity_resource_id" {
  type = string
}
