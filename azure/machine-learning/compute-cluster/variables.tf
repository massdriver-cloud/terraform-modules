variable "name" {
  type = string
}

variable "region" {
  type = string
}

variable "workspace_id" {
  type = string
}

variable "cluster" {
  type = object({
    name          = string
    size          = string
    min_nodes     = number
    max_nodes     = number
    idle_duration = number
  })
}

variable "tags" {
  type = any
}
