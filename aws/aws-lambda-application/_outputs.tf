output "function_arn" {
  description = "The amazon resource name of the function that was created"
  value       = aws_lambda_function.main.arn
}

output "identity_arn" {
  description = "ARN of the workload identity created for the lambda function"
  value       = module.application.id
}

output "identity_name" {
  description = "Name of the workload identity created for the lambda function"
  value       = local.role_name
}
