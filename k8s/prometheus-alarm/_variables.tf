variable "md_metadata" {
  description = "The `md_metadata` block from Massdriver"
  type        = any
}

variable "display_name" {
  type        = string
  description = "Short name to display in the massdriver UI."
}

variable "prometheus_alert_name" {
  description = "The name of the prometheus alert this alarm is associated with"
  type        = string
}
