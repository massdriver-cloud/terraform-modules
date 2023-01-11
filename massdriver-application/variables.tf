variable "name" {
  description = "The name of the application. This should be the Massdriver package name. var.md_metadata.name_prefix"
  type        = string
}

variable "service" {
  description = "The cloud service type that will run this workload."
  type        = string

  validation {
    condition     = contains(["function", "vm", "kubernetes"], var.service)
    error_message = "Allowed values for service are \"function\", \"vm\", or \"kubernetes\"."
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
    # OpenID Connect provider url produced by AKS,
    # needed by Azure for Workload Identity
    oidc_issuer_url = optional(string, null)
  })
}

variable "create_application_identity" {
  description = "If an application identity already exists, you can specify it here to skip the process of creating a new application identity."
  type        = bool
  default     = true
}

variable "application_identity_id" {
  description = "If an application identity already exists, you can specify it here to skip the process of creating a new application identity."
  type        = string
  default     = null
}
