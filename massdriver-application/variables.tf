variable "name" {
  description = "The name of the application."
  type        = string
}

variable "identity" {
  description = "The identity this application wil assume. Assume Role Policy for IAM ... TODO"
  type        = any
}

variable "root_path" {
  description = "Path to root module. This is used to load massdriver.yaml and params/connection variables."
  type        = string
}
