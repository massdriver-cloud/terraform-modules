variable "network_name" {
  type        = string
}

variable "cidr_mask" {
  type        = number
  default     = 16
}

variable "gcp_authentication" {
  type = any
}
