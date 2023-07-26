variable "md_metadata" {
  type        = any
  description = "Massdriver md_metadata object"
}

variable "pod_alarms" {
  description = "Install pod alarms"
  type        = bool
  default     = true
}

variable "deployment_alarms" {
  description = "Install deployment alarms"
  type        = bool
  default     = false
}

variable "statefulset_alarms" {
  description = "Install statefulset alarms"
  type        = bool
  default     = false
}

variable "daemonset_alarms" {
  description = "Install daemonset alarms"
  type        = bool
  default     = false
}

variable "job_alarms" {
  description = "Install job alarms"
  type        = bool
  default     = false
}

variable "hpa_alarms" {
  description = "Install HPA alarms"
  type        = bool
  default     = false
}
