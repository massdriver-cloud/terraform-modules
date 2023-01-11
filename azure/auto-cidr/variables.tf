variable "network_mask" {
  # dang, this tripped me up for a long time
  # this has to be a number, required by the resource
  type    = number
  default = 22
}

variable "virtual_network_id" {
  type = string
}
