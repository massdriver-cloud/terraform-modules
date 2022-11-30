# Massdriver Variables
variable "md_metadata" {
  type = any
}

variable "message" {
  type = string
}

variable "alarm_configuration" {
  type = object({
    threshold          = number
    metric_type        = string
    alignment_period_s = number
    duration_s         = number
    resource_type      = string
  })
}

# Massdriver variables
variable "display_name" {
  type        = string
  description = "Short name to display in the massdriver UI."
}

variable "notification_channel_id" {
  type        = string
  description = "Massdriver Alarm Channel - Notification Channel ID"
}
