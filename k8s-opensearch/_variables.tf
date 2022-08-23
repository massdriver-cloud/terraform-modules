variable "md_metadata" {
  type        = any
  description = "md_metadata object"
}

variable "kubernetes_cluster" {
  type        = any
  description = "A kubernetes_cluster artifact"
}

variable "release" {
  description = "Release name"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace"
  type        = string
}

variable "helm_additional_values" {
  description = "Map of additional values to configure in opensearch helm chart"
  default     = {}
}

variable "dashboards_helm_additional_values" {
  description = "Map of additional values to configure in opensearch-dashboards helm chart"
  default     = {}
}

variable "enable_dashboards" {
  description = "This will additionally deploy the opensearch-dashboards helm chart"
  default     = false
}

variable "ism_policies" {
  description = "Map of ISM policies to configure in the opensearch cluster. keys should be template names and bodies should be the ISM policy body"
  default     = {}
}
