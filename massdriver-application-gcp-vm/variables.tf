variable "container_image" {
  type = string
}

variable "port" {
  type = number
}

variable "max_instances" {
  type = number
}

variable "location" {
  type = string
}

variable "subnetwork" {
  type = any
}

variable "endpoint" {
  type = any
}

variable "machine_type" {
  type = string
}
