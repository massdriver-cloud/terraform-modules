variable "name_suffix" {
  type    = string
  default = null
}

variable "limit_amount" {
  default = 500
}

variable "subscriber_email_addresses" {
  default = []
}

variable "subscriber_sns_topic_arns" {
  default = []
}

variable "md_metadata" {
  type = any
}

locals {
  name              = var.name_suffix != null ? var.md_metadata.name_prefix + "-" + var.name_suffix : var.md_metadata.name_prefix
  package_tag_value = var.md_metadata.default_tags["md-package"]
}

resource "aws_budgets_budget" "main" {
  name         = local.name
  budget_type  = "COST"
  limit_amount = var.limit_amount
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  cost_filter {
    name = "TagKeyValue"
    values = [
      "md-package${"$"}${local.package_tag_value}"
    ]
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = var.subscriber_email_addresses
    subscriber_sns_topic_arns  = var.subscriber_sns_topic_arns
  }
}
