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

variable "kube_prometheus_stack_values" {
  description = "Map of additional values to configure the kube-prometheus-stack helm chart"
  type        = any
  default     = {}
}

variable "prometheus_rules_values" {
  description = "Map of additional values to configure the prometheus-rules helm chart"
  type        = any
  default     = {}
}
