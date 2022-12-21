variable "md_metdata" {
  type = any
}

variable  "gcp_project_id"  {
  description  =  "GCP project ID to use with cert-manager"
  type         =  string
}

variable "cloud_dns_managed_zones" {
  type = any
  default = []
}
