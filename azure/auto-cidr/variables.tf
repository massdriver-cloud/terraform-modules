variable "network_mask" {
  # this tripped me up for a while
  # this has to be a number, required by the resource
  # in some places this is a string like "/22"
  type    = number
  default = 22
}

variable "virtual_network_id" {
  type = string
}
