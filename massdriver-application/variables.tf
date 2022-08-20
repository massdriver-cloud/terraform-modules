variable "name" {
  description = "The name of the application."
  type        = string
}

variable "identity" {
  description = "The identity this application wil assume. Assume Role Policy for IAM ... TODO"
  type        = any
}
