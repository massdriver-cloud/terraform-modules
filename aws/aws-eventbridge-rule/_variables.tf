variable "name" {
  description = "Name of the Eventbridge Rule"
  type        = string
}

variable "event_filter" {
  description = "Determines whether to send all events or a subset to the target"
  type        = string

  validation {
    condition     = length(regexall("^(all|custom)$", var.event_filter)) > 0
    error_message = "Error: Valid types for event_filter are \"all\" and \"custom\""
  }
}

variable "event_filter_pattern" {
  description = "Filter pattern to use in choosing which events to send"
  type        = string
  default     = "{}"

  validation {
    condition     = can(jsonencode(var.event_filter_pattern))
    error_message = "Error: event_filter_pattern must be valid JSON"
  }
}

variable "target_resource_arn" {
  description = "The ARN of the event rule target"
  type        = string
}

variable "event_bus_arn" {
  description = "The ARN of the event bus to attach the rule to"
  type        = string
}
