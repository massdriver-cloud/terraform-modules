variable "name" {
  description = "The name of the application. This should be the Massdriver package name. var.md_metadata.name_prefix"
  type        = string
}

# TODO: should we call this workload or runtime? Does service make sense?
variable "service" {
  description = "The cloud service type that will run this workload."
  type        = string

  validation {
    condition     = contains(["function", "vm", "kubernetes"], var.service)
    error_message = "Allowed values for service are \"function\", \"vm\", or \"kubernetes\"."
  }
}
