variable "name" {
  type        = string
  description = "The name of the resource."
}

variable "location" {
  type        = string
  description = "The location of the resource."
}

variable "tags" {
  type        = any
  description = "The tags of the resource."
}

variable "kind" {
  type        = string
  description = "The Cognitive service to deploy."
}

variable "sku_name" {
  type        = string
  description = "The SKU of the Cognitive service."
}
