output "function_arn" {
  description = "The amazon resource name of the function that was created"
  value       = aws_lambda_function.main.arn
}
