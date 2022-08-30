variable "container_image" {
  type = string
}

variable "location" {
  type = string
}

variable "endpoint" {
  default = null
  type = object({
    subdomain = string,
    zone      = string
  })
}
