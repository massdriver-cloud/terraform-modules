variable "name" {
  type = string
}

variable "endpoint_configuration" {
  type    = string
  default = "EDGE"
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

variable "enable_ssl" {
  type = bool
}
