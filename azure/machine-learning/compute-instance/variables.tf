variable "name" {
  type = string
}

variable "region" {
  type = string
}

variable "workspace_id" {
  type = string
}

variable "instance" {
  type = object({
    name = string
    size = string
  })
}

variable "tags" {
  type = any
}
