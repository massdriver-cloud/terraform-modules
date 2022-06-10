locals {
  enable_alarms = var.md_metadata.observability.alarm_channels.aws != null
}
resource "aws_cloudwatch_metric_alarm" "alarm" {
  count      = local.enable_alarms ? 1 : 0
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
  alarm_actions   = [var.md_metadata.observability.alarm_channels.aws.arn]
  ok_actions      = [var.md_metadata.observability.alarm_channels.aws.arn]
}
