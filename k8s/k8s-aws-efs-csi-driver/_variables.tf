variable "name_prefix" {
  type        = string
  description = "name prefix to apply to resources object"
}

variable "eks_cluster_arn" {
  type        = string
  description = "A kubernetes_cluster artifact"
}

variable "eks_oidc_issuer_url" {
  type        = string
  description = "A kubernetes_cluster artifact"
  validation {
    # regex(...) fails if it cannot find a match
    condition     = can(regex("^https://.*$", var.eks_oidc_issuer_url))
    error_message = "The eks_oidc_issuer_url variable must be an https endpoint."
  }
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