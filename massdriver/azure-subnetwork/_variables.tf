variable "md_metadata" {
  type = object({
    name_prefix  = string
    default_tags = any
  })
}

variable "region" {
  type        = string
  description = "With Massdriver, you don't have to worry about your Cloud: https://docs.massdriver.cloud/bundles/custom-widgets-and-fields#supported-cloud-locations-regions"
}

variable "network_mask" {
  type = string
}

variable "virtual_network_id" {
  type = string
}

variable "enable_auto_cidr" {
  type        = bool
  description = "We'll automatically size your network for you, you get back to the fun stuff."
  default     = true
}
