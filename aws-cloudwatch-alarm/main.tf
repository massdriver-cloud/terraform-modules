resource "aws_cloudwatch_metric_alarm" "alarm" {
  alarm_name = var.alarm_name
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
  alarm_actions   = [var.alarm_sns_topic_arn]
  ok_actions      = [var.alarm_sns_topic_arn]
}
