variable "domain_name" {
  type        = string
  description = "Domain name for which the certificate should be issued"
}

variable "subject_alternative_names" {
  type        = set(string)
  description = "Set of domains that should be SANs in the issued certificate."
  default     = []
}

variable "private_zone" {
  type        = bool
  description = "Boolean indicating whether the Route53 zone is private (default false)"
  default     = false
}
