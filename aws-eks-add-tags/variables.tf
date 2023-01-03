variable "tags" {
  type = map(string)
}

variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster"
}
