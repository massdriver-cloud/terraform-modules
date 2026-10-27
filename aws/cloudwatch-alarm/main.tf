locals {
  # Legacy default tags have no md-instance, only md-package (the name_prefix).
  instance = try({ "md-instance" = var.md_metadata.default_tags["md-instance"] }, { name_prefix = var.md_metadata.name_prefix })
}

resource "aws_cloudwatch_metric_alarm" "alarm" {
  alarm_name = var.alarm_name

  # CloudWatch alarm notifications carry no resource tags. Massdriver reads the
  # instance identifier from this JSON to attach the alarm to its instance.
  alarm_description = jsonencode(merge(local.instance, { message = var.message }))

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

resource "massdriver_instance_alarm" "instance_alarm" {
  display_name      = var.display_name
  cloud_resource_id = aws_cloudwatch_metric_alarm.alarm.arn
  metric {
    name       = var.metric_name
    namespace  = var.namespace
    statistic  = var.statistic
    dimensions = var.dimensions
  }
}
