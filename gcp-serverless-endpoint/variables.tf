variable "resource_name" {
  type = string
}

variable "labels" {
  type = any
}

variable "subdomain" {
  type = string
}

variable "location" {
  type = string
}

variable "zone" {
  type = string
}

variable "cloud_run_service_name" {
  type    = string
  default = null
}

variable "cloud_function_service_name" {
  type    = string
  default = null
}
