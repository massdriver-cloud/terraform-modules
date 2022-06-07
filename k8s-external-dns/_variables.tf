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

variable "domain_filters" {
  type        = string
  description = "a comman-separated list of domains to allow"
}

variable "helm_additional_values" {
  type        = any
  description = "a map of helm variables (key) to their values, used for setting anything in values.yaml"
  default     = {}
}

variable "dns_provider" {
  type        = string
  description = "the name of the DNS provider, supported values are [aws, google]"
}
