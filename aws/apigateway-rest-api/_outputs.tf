output "arn" {
  description = "The ARN of the API Gateway"
  value       = aws_api_gateway_rest_api.main.arn
}

output "stage_arn" {
  description = "The ARN of the API Gateway stage"
  value       = aws_api_gateway_stage.main.arn
}
