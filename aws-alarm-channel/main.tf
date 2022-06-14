variable "md_metadata" {
  description = "Massdriver package metadata object."
  type        = any
}

resource "aws_sns_topic" "main" {
  name         = "${var.md_metadata.name_prefix}-alarms"
  display_name = "Massdriver Alarms"
  # https://docs.aws.amazon.com/sns/latest/dg/sns-message-delivery-retries.html
  delivery_policy = <<EOF
  {
    "http": {
      "defaultHealthyRetryPolicy": {
        "numNoDelayRetries": 5,
        "minDelayTarget": 1,
        "numMinDelayRetries": 5,
        "maxDelayTarget": 3,
        "numMaxDelayRetries": 5,
        "numRetries": 30
      },
      "disableSubscriptionOverrides": false
    }
  }
  EOF
}

resource "aws_sns_topic_subscription" "main" {
  endpoint  = var.md_metadata.observability.alarm_webhook_url
  protocol  = "https"
  topic_arn = aws_sns_topic.main.arn
}

output "arn" {
  description = "Alarm Channel AWS SNS Topic ARN"
  value       = aws_sns_topic.main.arn
}
