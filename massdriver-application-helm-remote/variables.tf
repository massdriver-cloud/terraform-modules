variable "kubernetes_cluster" {
  description = "Massdriver Kubernetes Cluster Artifact"
  type        = any
}

variable "namespace" {
  description = "Namespace to deploy chart into"
  type        = string
}

variable "name" {
  description = "The release name of the chart, this should be your var.md_metadata.name_prefix"
  type        = string
}

variable "chart" {
  description = "The path to your Helm chart"
  type        = string
  default     = "grafana/mimir-distributed"
}

variable "chart_repository" {
  type    = string
  default = "https://grafana.github.io/helm-charts"
}

variable "helm_values" {
  description = "Additional Helm values to pass to the chart"
  type        = any
}




variable "additional_envs" {
  description = "Additional environment variables to set"
  type = list(
    object({
      name  = string
      value = string
    })
  )
  default = []
}
