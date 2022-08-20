variable "name" {
  description = "The name of the application."
  type        = string
}

variable "identity" {
  description = "Configures the cloud services (lambda, ec2, k8s, etc) that can assume this identity (IAM Role / Service Account)"
  type        = any
}
