variable "image" {
  type = object({
    repository = string
    tag        = string
  })
}

variable "dns" {
  type = any
}

variable "application" {
  type = object({
    location             = string
    sku_name             = string
    minimum_worker_count = number
    maximum_worker_count = number
  })
}

variable "name" {
  type = string
}

variable "tags" {
  type = any
}

variable "contact_email" {
  type = string
}

variable "command" {
  type    = string
  default = null
}

variable "virtual_network_id" {
  type = string
}

variable "subnet_cidr" {
  type        = string
  description = "The CIDR block for the subnet. Max size of /24, minimum of /28"
}
