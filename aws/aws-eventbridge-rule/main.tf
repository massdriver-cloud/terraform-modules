locals {
  all_events_pattern    = "{\"source\": [{ \"prefix\": \"\" }]}"
  default_event_pattern = var.event_filter_pattern == "{}" ? local.all_events_pattern : var.event_filter_pattern
  event_pattern         = var.event_filter == "all" ? local.all_events_pattern : local.default_event_pattern
  name                  = "${var.name}-event-rule"
}

resource "aws_cloudwatch_event_rule" "main" {
  name           = local.name
  event_bus_name = var.event_bus_arn
  event_pattern  = local.event_pattern
}

resource "aws_cloudwatch_event_target" "main" {
  event_bus_name = var.event_bus_arn
  rule           = aws_cloudwatch_event_rule.main.name
  target_id      = "${local.name}-target"
  arn            = var.target_resource_arn
  role_arn       = aws_iam_role.eventbridge_rule_role.arn
}

resource "aws_iam_role" "eventbridge_rule_role" {
  name               = "${var.name}-role"
  description        = "Event role assumed by an Eventbridge rule to push events to other AWS Services"
  assume_role_policy = data.aws_iam_policy_document.eventbridge_assume_role_document.json
}

data "aws_iam_policy_document" "eventbridge_assume_role_document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}
