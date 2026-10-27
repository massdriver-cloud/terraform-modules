resource "aws_cloudwatch_metric_alarm" "alarm" {
  alarm_name = var.alarm_name

  # CloudWatch alarm notifications carry no resource tags. Massdriver reads the
  # instance identifier from this JSON to attach the alarm to its instance.
  alarm_description = jsonencode({
    "md-instance" = var.md_metadata.default_tags["md-instance"]
    message       = var.message
  })

  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = var.threshold
  dimensions          = var.dimensions

  actions_enabled = "true"
  alarm_actions   = [var.sns_topic_arn]
  ok_actions      = [var.sns_topic_arn]
}

resource "massdriver_package_alarm" "package_alarm" {
  display_name      = var.display_name
  cloud_resource_id = aws_cloudwatch_metric_alarm.alarm.arn
  metric {
    name       = var.metric_name
    namespace  = var.namespace
    statistic  = var.statistic
    dimensions = var.dimensions
  }
}
