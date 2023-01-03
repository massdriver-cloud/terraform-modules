resource "aws_cloudwatch_metric_alarm" "alarm" {
  alarm_name = var.alarm_name

  # We need to 'smuggle' our name_prefix for the package back to massdriver
  # so we can show the alarms on the correct manifest in the UI
  alarm_description = var.message

  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  threshold           = var.threshold

  dynamic "metric_query" {
    for_each = var.metric_queries
    content {
      id          = metric_query.key
      expression  = try(metric_query.value.expression, null)
      label       = metric_query.value.label
      return_data = metric_query.value.return_data

      dynamic "metric" {
        for_each = metric_query.value.metric != null ? toset(["metric"]) : toset([])
        content {
          metric_name = metric_query.value.metric.metric_name
          namespace   = metric_query.value.metric.namespace
          period      = metric_query.value.metric.period
          stat        = try(metric_query.value.metric.stat, null)
          unit        = try(metric_query.value.metric.unit, null)

          dimensions = try(metric_query.value.metric.dimensions, {})
        }
      }
    }
  }

  actions_enabled = "true"
  alarm_actions   = [var.sns_topic_arn]
  ok_actions      = [var.sns_topic_arn]
}

resource "massdriver_package_alarm" "package_alarm" {
  display_name      = var.display_name
  cloud_resource_id = aws_cloudwatch_metric_alarm.alarm.arn
}
