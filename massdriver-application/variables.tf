variable "name" {
  description = "The name of the application. This should be the Massdriver package name. var.md_metadata.name_prefix"
  type        = string
}

variable "service" {
  description = "The cloud service type that will run this workload."
  type        = string

  validation {
    condition     = contains(["function", "container", "vm", "kubernetes"], var.service)
    error_message = "Allowed values for service are \"function\", \"container\", \"vm\", or \"kubernetes\"."
  }
}

variable "kubernetes" {
  description = "Kubernetes configuration for binding the application identity to k8s workload identity (GCP) or federated assume role (AWS). Required if service='kubernetes'."
  default     = null
  type = object({
    # k8s namespace workload will run in
    namespace = string,
    # Massdriver connection artifact
    cluster_artifact = any
  })
}

variable "resource_group_name" {
  description = "Azure only, the name of resource group to create the Managed Identity in."
  type        = string
  default     = null
}

variable "location" {
  description = "Azure only, the location of the resource group."
  type        = string
  default     = null
}
