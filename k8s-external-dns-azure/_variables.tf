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

variable "azure_dns_zones" {
  type = object({
    dns_zones      = set(string)
    resource_group = string
  })
  default = {
    dns_zones      = []
    resource_group = ""
  }
}
