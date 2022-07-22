variable "md_metadata" {
  description = "Massdriver package metadata object"
  type        = any
}

variable "key_alias_context" {
  description = "(Optional) Additional string context to append to the end of the key alias. This is useful in bundles where multiple keys are created and you need to give context to differentiate each key. Must be lowercase letters and hyphens without spaces and no more than 20. If this field is not empty, it will be appended to the end of the alias with a hyphen"
  type        = string
  default     = ""

  validation {
    # regex(...) fails if it cannot find a match
    condition     = can(regex("^([a-z]{0,20}|[a-z][a-z0-9-]{0,19})$", var.key_alias_context))
    error_message = "The key_alias_context variable must begin with a letter, contain only lowercase letters, numbers or hyphens and be 20 characters or less."
  }
}

variable "policy" {
  description = "IAM policy to apply to the KMS key"
  type        = string
}
