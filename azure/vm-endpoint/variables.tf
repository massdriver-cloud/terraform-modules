variable "name" {
  type = string
}

variable "subdomain" {
  type = string
}

variable "domain" {
  type = string
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
    port = optional(number, 80)
    path = optional(string, "/health")
  })
}

variable "subnet_id" {
  type = string
}

variable "tags" {
  type    = any
  default = []
}

variable "port" {
  type    = number
  default = 80
}
