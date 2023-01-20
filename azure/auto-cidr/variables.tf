variable "network_mask" {
  # this tripped me up for a bit
  # this has to be a number, required by the resource
  # in some places we express this as a string prefixed with a slash: "/22"
  type    = number
  default = 22
}

variable "virtual_network_id" {
  type = string
}
