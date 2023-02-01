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
