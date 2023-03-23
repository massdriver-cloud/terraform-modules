output "stream_arn" {
  description = "Kinesis stream ARN"
  value       = aws_kinesis_stream.main.arn
}

output "read_policy_arn" {
  description = "Kinesis stream read policy ARN"
  value       = aws_iam_policy.read.arn
}

output "write_policy_arn" {
  description = "Kinesis stream write policy ARN"
  value       = aws_iam_policy.write.arn
}

output "manage_policy_arn" {
  description = "Kinesis stream manage policy ARN"
  value       = aws_iam_policy.manage.arn
}
