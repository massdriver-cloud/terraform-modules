output "function_arn" {
  description = "The amazon resource name of the function that was created"
  value       = module.aws_lambda_function.function_arn
}

output "function_invoke_arn" {
  description = "The Amazon Resource Name of the invocation API"
  value       = module.aws_lambda_function.invoke_arn
}

output "identity" {
  description = "Cloud ID for application IAM. For AWS this is an IAM Role ARN."
  value       = module.application.identity
}
