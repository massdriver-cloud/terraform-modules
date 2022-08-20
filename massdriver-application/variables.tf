variable "name" {
  description = "The name of the application. This should be the Massdriver package name. var.md_metadata.name_prefix"
  type        = string
}

variable "identity" {
  description = "Configures the cloud services (lambda, ec2, k8s, etc) that can assume this identity (IAM Role / Service Account)"
  type        = any
}
