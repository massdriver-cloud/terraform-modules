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
    maximum_worker_count = number
  })
}

variable "name" {
  type = string
}

variable "tags" {
  type = any
}
