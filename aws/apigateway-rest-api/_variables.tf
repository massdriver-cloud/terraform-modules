variable "name" {
  type = string
}

variable "endpoint_configuration" {
  type        = string
  description = "Regional or Global API Gateway. Accepted values are \"EDGE\" or \"REGIONAL\""

  validation {
    condition     = contains(["REGIONAL", "EDGE"], var.endpoint_configuration)
    error_message = "Allowed values are \"EDGE\" or \"REGIONAL\""
  }
}

variable "stage_name" {
  type = string
}

variable "domain" {
  type = string
}

variable "hosted_zone_id" {
  type = string
}

variable "certificate_arn" {
  type = string
}
