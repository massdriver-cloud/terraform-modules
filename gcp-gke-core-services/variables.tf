variable "md_metadata" {
  type = any
}

variable "kubernetes_cluster_artifact" {
  type        = any
  description = "The Massdriver Kubernetes Cluster artifact."
}

variable "cloud_dns_managed_zones" {
  type    = any
  default = []
}

variable "enable_ingress" {
  type    = bool
  default = false
}

variable "logging" {
  type = object({
    opensearch = optional(object({
      enabled             = bool
      persistence_size_gi = optional(number, 10)
      retention_days      = optional(number, 7)
    }))
  })
  default = null
}

variable "node_groups" {
  type    = any
  default = []
}

variable "gcp_config" {
  type = object({
    project_id = string
    region     = string
  })
}
