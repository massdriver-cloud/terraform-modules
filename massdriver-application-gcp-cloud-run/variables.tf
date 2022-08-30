variable "container_image" {
  type = string
}

variable "location" {
  type = string
}

variable "zone" {
  type    = string
  default = null
}

variable "subdomain" {
  type    = string
  default = null
}
