variable "cloud_dns_managed_zones" {
  type = any
  default = []
}

variable "vpc_grn" {
  type = string
}

variable "enable_ingress" {
  type = bool
  default = false
}

variable "logging" {
  type = object({
    opensearch = optional(object({
      enabled = bool
      persistence_size_gi = optional(number, 10)
      retention_days = optional(number, 7)
    }))
  })
  default = null
}

variable "node_groups" {
  type = any
  default = []
}

variable "md_metadata" {
  type = any
}

variable "gcp_project_id" {
  description = "GCP project ID to use with cert-manager"
  type        = string
}

variable "gcp_region" {
  type        = string
}

variable "control_plane_ipv4_cidr_block" {
type = string
}
