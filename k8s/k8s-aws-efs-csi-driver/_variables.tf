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

variable "storage_class_to_efs_arn_map" {
  description = "Map of storage class names to EFS volume ARNs"
  default     = {}
}

variable "helm_additional_values" {
  description = "Map of additional values to configure in helm chart"
  default     = {}
}