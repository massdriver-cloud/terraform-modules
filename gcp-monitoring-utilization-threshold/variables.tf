# Massdriver Variables
variable "md_metadata" {
  type = any
}

variable "message" {
  type = string
}

variable "notification_channel_id" {
  type        = string
  description = "Massdriver Alarm Channel - Notification Channel ID"
}

variable "threshold" {
  type = number
}

variable "duration" {
  type = string
}
variable "period" {
  type = string
}

variable "alarm_name" {
  type = string
}

variable "metric_type" {
  type = string
}

variable "resource_type" {
  type = string
}
