variable "name" {
  type = string
}

variable "retention_hours" {
  type = number

  validation {
    condition     = var.retention_hours <= 8760 && var.retention_hours >= 24
    error_message = "Retention must be greater than or equal to 24 and less than or equal to 8760"
  }
}

variable "stream_mode" {
  type = string

  validation {
    condition     = contains(["ON_DEMAND", "PROVISIONED"], var.stream_mode)
    error_message = "Value of stream_mode must be ON_DEMAND or PROVISIONED"
  }
}

variable "shard_count" {
  type = number

  validation {
    condition     = (var.shard_count == null) || try((var.shard_count >= 1 && var.shard_count <= 4096), false)
    error_message = "shard_count must be greater than 0 and less than 4097"
  }
}

variable "shard_level_metrics" {
  type    = set(string)
  default = []
}
