variable "cloud_resource_id" {
  description = "The cloud resource ID."
  type        = string
}

variable "display_name" {
  description = "The display name of the alarm."
  type        = string
}

variable "metric_name" {
  description = "The name of the metric."
  type        = string
}

variable "metric_namespace" {
  description = "The namespace of the metric."
  type        = string
}

variable "statistic" {
  description = "The statistic of the metric."
  type        = string
}

variable "dimensions" {
  description = "Dimensions map for the metric."
  type        = any
}
