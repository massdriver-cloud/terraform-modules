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

variable "cluster_type" {
  description = "The type of cluster you want to create."
  type        = string
  default     = "REPLICASET"
}

variable "num_shards" {
  description = "The number of shards to use in the database"
  type        = number
  default     = 1
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
  default     = "M10"
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

variable "ebs_volume_type" {
  description = "The the type of EBS volume to use for storage"
  type        = string
  default     = "STANDARD"
}

variable "disk_iops" {
  description = "The provisioned IOPS if the EBS type is \"PROVISIONED\""
  type        = number
  default     = null
}

variable "disk_size_gb" {
  description = "The size of the disk for data storage"
  type        = number
  default     = 20
}

variable "backup_enabled" {
  description = "Whether to enable cloud backups"
  type        = bool
  default     = true
}

variable "pit_enabled" {
  description = "Whether to enable continuous cloud backups (in addition to snapshot backups)"
  type        = bool
  default     = true
}

variable "backup_schedule" {
  description = "List of backup schedule policies"
  type = list(
    object({
      frequency_type     = string
      frequency_interval = number
      retention_unit     = string
      retention_value    = number
  }))
  default = [{
    frequency_type     = "daily"
    frequency_interval = 1
    retention_unit     = "weeks"
    retention_value    = 4
  }]
}

variable "termination_protection_enabled" {
  description = "Whether to enable termination protection on the cluster"
  type        = bool
  default     = false
}

variable "labels" {
  description = "Labels to associate with mongodb atlas resources"
  type        = map(string)
}
