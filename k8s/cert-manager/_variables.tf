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
  type    = any
  default = {}
}
