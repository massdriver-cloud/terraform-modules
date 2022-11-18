output "arn" {
  description = "The ARN of the event rule"
  value       = aws_cloudwatch_event_rule.main.arn
}

output "role_name" {
  description = "The name of the role assumed by the event rule"
  value       = aws_iam_role.eventbridge_rule_role.name
}

output "role_arn" {
  description = "The ARN of the role assumed by the event rule"
  value       = aws_iam_role.eventbridge_rule_role.arn
}
