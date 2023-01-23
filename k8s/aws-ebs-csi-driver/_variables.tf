variable "eks_cluster_arn" {
  type        = string
  description = "EKS cluster ARN"
}

variable "eks_oidc_issuer_url" {
  type        = string
  description = "A kubernetes_cluster artifact"
  validation {
    # regex(...) fails if it cannot find a match
    condition     = can(regex("^https://.*$", var.eks_oidc_issuer_url))
    error_message = "The eks_oidc_issuer_url variable must be an https endpoint."
  }
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes cluster version in semver notation"
}
