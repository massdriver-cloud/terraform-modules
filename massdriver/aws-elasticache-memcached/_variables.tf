variable "md_metadata" {
  type = any
}

variable "replicas" {
  type = number
}

variable "cluster_mode_enabled" {
  type = bool
}

variable "cidr" {
  type = any
}

variable "node_groups" {
  type = any
}

variable "internal_subnets" {
  type = any
}

variable "private_subnets" {
  type = any
}

variable "vpc_id" {
  type = any
}

variable "secure" {
  type = bool
}

variable "subnet_type" {
  type = any
}

variable "memcached_version" {
  type = any
}

variable "node_type" {
  type = any
}

variable "num_nodes" {
  type = any
}
