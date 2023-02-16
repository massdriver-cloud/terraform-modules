resource "aws_cloudwatch_metric_alarm" "alarm" {
  alarm_name = var.alarm_name

  # We need to 'smuggle' our name_prefix for the package back to massdriver
  # so we can show the alarms on the correct manifest in the UI
  alarm_description = jsonencode({
    name_prefix = var.md_metadata.name_prefix
    message     = var.message
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
    name = var.metric_name
    namespace = var.namespace
    statistic = var.statistic
    dimensions = var.dimensions
  }
}
