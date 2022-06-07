# Massdriver Variables
variable "md_metadata" {
  type = any
}

variable "message" {
  type = string
}

variable "alarm_sns_topic_arn" {
  type = string
}

# Cloudwatch Variables
variable "alarm_name" {
  type        = string
  description = "The descriptive name for the alarm. This name must be unique within the user's AWS account"
}

variable "comparison_operator" {
  type        = string
  description = "The arithmetic operation to use when comparing the specified Statistic and Threshold."
}

variable "evaluation_periods" {
  type        = string
  description = "The number of periods over which data is compared to the specified threshold."
}

variable "metric_name" {
  type        = string
  description = "The name for the alarm's associated metric. See docs for supported metrics."
}

variable "namespace" {
  type        = string
  description = "The namespace for the alarm's associated metric. See docs for the list of namespaces. See docs for supported metrics."
}

variable "period" {
  type        = string
  description = "The period in seconds over which the specified statistic is applied."
}

variable "statistic" {
  type        = string
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum"
}

variable "threshold" {
  type        = string
  description = "The value against which the specified statistic is compared."
}

variable "dimensions" {
  type        = map(string)
  description = "The value against which the specified statistic is compared."
}
