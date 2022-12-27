# Massdriver Variables
variable "md_metadata" {
  type = any
}

variable "message" {
  type = string
}

variable "sns_topic_arn" {
  type        = string
  description = "Massdriver Alarm Channel - SNS Topic ARN"
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

variable "threshold" {
  type        = string
  description = "The value against which the specified statistic is compared."
}

variable "metric_queries" {
  type = map(object({
    expression  = optional(string)
    label       = optional(string)
    return_data = optional(string)
    metric = optional(object({
      metric_name = string
      namespace   = string
      period      = string
      stat        = string
      unit        = optional(string)
      dimensions  = optional(map(string))
    }))
  }))
  description = "Map of id to metric_query object. See the [`aws_cloudwatch_metric_alarm`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) documentation for object structure"
}

variable "display_name" {
  type        = string
  description = "Short name to display in the massdriver UI."
}
