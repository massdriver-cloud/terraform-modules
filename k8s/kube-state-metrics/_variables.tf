variable "md_metadata" {
  type        = any
  description = "md_metadata object"
}

variable "release" {
  description = "Release name"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace"
  type        = string
}
