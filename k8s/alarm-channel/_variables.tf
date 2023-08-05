variable "md_metadata" {
  type        = any
  description = "Massdriver md_metadata object"
}

variable "release" {
  description = "Release name"
  type        = string
  default     = null
}

variable "namespace" {
  description = "Kubernetes namespace"
  type        = string
}
