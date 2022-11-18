variable "name" {
  description = "Name of the Firehose"
  type        = string
}

variable "dynamic_partitioning_enabled" {
  description = "Enable s3 partitioning to group events in to unique keys in s3 based on a JQ query"
  type        = bool
  default     = false
}

variable "destination" {
  description = "Service to send data to from Firehose"
  type        = string
}

variable "buffer_size" {
  description = "Batch size in MB to send data to the destination"
  type        = number
  default     = 64
}

variable "buffer_interval" {
  description = "Amount of time in seconds in which to send data to the destination if the buffer size has not been fulfilled"
  type        = number
  default     = 300
}

variable "query" {
  description = "JQ query which can extract a partition key from events"
  type        = string
}

variable "bucket_arn" {
  description = "ARN of the destination bucket for Firehose to deliver to"
  type        = string
}

variable "write_policy_arn" {
  description = "ARN of the write policy for the bucket"
  type        = string
}
