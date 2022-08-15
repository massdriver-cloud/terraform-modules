variable "md_metadata" {
  type        = any
  description = "md_metadata object"
}

// TODO this is only used in configuring my local dev provider. remove before merging.
variable "kubernetes_cluster" {
  type        = any
  description = "A kubernetes_cluster artifact"
}

variable "release" {
  description = "Release name"
  type        = string
  default     = "opensearch"
}

variable "namespace" {
  description = "Kubernetes namespace"
  type        = string
  default     = "opensearch"
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