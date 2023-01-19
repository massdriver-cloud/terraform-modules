output "function_arn" {
  description = "The amazon resource name of the function that was created"
  value       = aws_lambda_function.main.arn
}

output "invoke_arn" {
  description = "The Amazon Resource Name of the invocation API"
  value       = aws_lambda_function.main.invoke_arn
}
