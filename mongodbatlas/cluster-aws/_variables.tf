variable "mongodb_organization_id" {
  description = "The MongoDB Atlas Organization ID"
  type        = string
}

variable "name" {
  description = "Name of project to create in MongoDB atlas"
  type        = string
}

variable "region" {
  description = "The AWS region to create the MongoDB Atlas cluster in"
  type        = string
}

variable "mongodb_version" {
  description = "The MongoDB version to use in the Cluser"
  type        = string
  default     = "4.4"
}

variable "vpc_id" {
  description = "The AWS VPC to create the private link to the MongoDB cluster"
  type        = string
}

variable "subnet_ids" {
  description = "The subnet APIs where to create the private link to the MongoDB cluster"
  type        = set(string)
}

variable "electable_node_count" {
  description = "The number of electable nodes"
  type        = number
  default     = 3
}

variable "instance_size" {
  description = "The instance size"
  type        = string
  default     = "M20"
}

variable "min_instance_size" {
  description = "The min instance size"
  type        = string
  default     = "M10"
}

variable "max_instance_size" {
  description = "The max instance size"
  type        = string
  default     = "M80"
}

variable "disk_size_gb" {
  description = "The size of the disk for data storage"
  type        = number
  default     = 20
}

variable "labels" {
  description = "Labels to associate with mongodb atlas resources"
  type        = map(string)
}
