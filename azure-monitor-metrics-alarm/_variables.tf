# Massdriver Variables
variable "md_metadata" {
  type = any
}

variable "message" {
  type = string
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group of the Monitor Action Group and Metric Rules."
}

variable "alarm_name" {
  type        = string
  description = "The name of the Metric Alert."
}

variable "scopes" {
  type        = set(string)
  description = "A set of strings of resource IDs at which the metric criteria should be applied."
}

# Azure Monitor variables
variable "frequency" {
  type        = string
  description = "The evaluation frequency of this Metric Alert, represented in ISO 8601 duration format. Possible values are PT1M, PT5M, PT15M, PT30M and PT1H. Defaults to PT1M."
}

variable "severity" {
  type        = string
  description = "The severity of this Metric Alert. Possible values are 0, 1, 2, 3 and 4. Defaults to 3."
}

variable "window_size" {
  type        = string
  description = "The period of time that is used to monitor alert activity, represented in ISO 8601 duration format. This value must be greater than frequency."
}

variable "metric_namespace" {
  type        = string
  description = "One of the metric namespaces to be monitored."
}

variable "metric_name" {
  type        = string
  description = "One of the metric names to be monitored."
}

variable "aggregation" {
  type        = string
  description = "The statistic that runs over the metric values. Possible values are Average, Count, Minimum, Maximum and Total."
}

variable "operator" {
  type        = string
  description = "The criteria or dimension operator. Possible values are Equals, NotEquals, GreaterThan, GreaterThanOrEqual, LessThan and LessThanOrEqual."
}

variable "threshold" {
  type        = string
  description = "The criteria threshold value that activates the alert."
}

variable "dimensions" {
  type = set(object({
    name     = string
    operator = string
    values   = list(string)
    })
  )
  default = []
}
