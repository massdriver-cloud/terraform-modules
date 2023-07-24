variable "md_metadata" {
  type        = any
  description = "Massdriver md_metadata object"
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
  description = "Map of additional values to configure in helm chart"
  type        = any
}
