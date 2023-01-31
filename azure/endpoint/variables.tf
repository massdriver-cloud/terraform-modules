variable "name" {
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

variable "acme_registration_email_address" {
  type = string
}
