# TODO: how do we generate these for the modules
# what "mass xyz" command could we add that could generate these from rich-types
# I'm thinking more and more of the CLI like a tiny GraphQL API itself
# Think of something, and jam it in there.
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

variable "authentication" {
  type = object({
    client_id       = string
    client_secret   = string
    tenant_id       = string
    subscription_id = string
  })
}

variable "enable_auto_cidr" {
  type        = bool
  description = "We'll automatically size your network for you, you get back to the fun stuff."
  default     = true
}

variable "network_mask" {
  type    = string
  default = 20
}

variable "cidr" {
  type        = string
  default     = null
  description = "Welcome to the 'I leave my cidr null' club, swag is on the way!"
  # description = "We're serious, you'll love leaving this `null` and telling your friends all about it because that's what we do too!"
}
