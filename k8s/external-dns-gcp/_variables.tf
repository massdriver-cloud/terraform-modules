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

variable "cloud_dns_managed_zones" {
  description = "Map Of GCP Cloud DNS managed zones"
  type        = map(string)
  default     = {}
}

variable "gcp_project_id" {
  description = "GCP project ID to use with cert-manager"
  type        = string
}
