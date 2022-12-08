variable "alarm_configuration" {
  type = object({
    metric_type        = string
    resource_type      = string
    threshold          = number
    duration_s         = optional(number, 60)
    alignment_period_s = optional(number, 60)
    value_type         = optional(string, "DOUBLE")
  })
  validation {
    condition     = var.alarm_configuration.duration_s >= 60
    error_message = "The duration must be at least 60 seconds, it's currently ${var.alarm_configuration.duration_s}."
  }
  validation {
    condition     = var.alarm_configuration.alignment_period_s >= 60
    error_message = "The alignment period must be at least 60 seconds, it's currently ${var.alarm_configuration.alignment_period_s}."
  }
  validation {
    condition = {
      "DOUBLE" = true
      "INT64"  = true
      "BOOL"   = true
      "STRING" = true
    }[var.alarm_configuration.value_type]
    error_message = "${var.alarm_configuration.value_type} is not a valid value type."
  }
}

# Massdriver metadata
variable "md_metadata" {
  type = any
}

# Massdriver variables
variable "message" {
  type        = string
  description = "A message including additional context for this alarm."
}

variable "display_name" {
  type        = string
  description = "Short name to display in the massdriver UI."
}

variable "notification_channel_id" {
  type        = string
  description = "Massdriver Alarm Channel - Notification Channel ID"
}

variable "cloud_resource_id" {
  type        = string
  description = "The identifier for what resource is producing the metrics. Usually it's the self_link attribute of the resource."
}
