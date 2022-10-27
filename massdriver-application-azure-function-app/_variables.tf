variable "docker" {
  type = object({
    registry = string
    image    = string
    tag      = string
  })
}


variable "application" {
  type = object({
    location             = string
    sku_name             = string
    minimum_worker_count = number
    maximum_worker_count = number
    cidr                 = string
    runtime              = string
  })
}

variable "dns" {
  type = any
}

variable "name" {
  type = string
}

variable "tags" {
  type = any
}

variable "virtual_network_id" {
  type = string
}

variable "contact_email" {
  type = string
}
