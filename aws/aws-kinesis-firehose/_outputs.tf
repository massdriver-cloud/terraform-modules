output "role_name" {
  description = "The name of the role assumed by firehose"
  value       = aws_iam_role.firehose_role.name
}

output "role_arn" {
  description = "The arn of the role assumed by firehose"
  value       = aws_iam_role.firehose_role.arn
}

output "arn" {
  description = "The Amazon resource ID of the firehose"
  value       = aws_kinesis_firehose_delivery_stream.main.arn
}
