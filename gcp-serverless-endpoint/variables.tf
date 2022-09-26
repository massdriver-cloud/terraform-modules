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
<<<<<<< HEAD:gcp-endpoint/variables.tf

variable "managed_instance_groups" {
  type    = any
  default = null
}

variable "managed_instance_group_health_check" {
  type = object({
    port = number
    path = string
  })
  default = {
    port = 80
    path = "/"
  }
}
=======
>>>>>>> ccae04e (revert changes to endpoint):gcp-serverless-endpoint/variables.tf
