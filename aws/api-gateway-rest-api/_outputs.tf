output "arn" {
  description = "The ARN of the API Gateway"
  value       = aws_api_gateway_rest_api.main.arn
}

output "stage_arn" {
  description = "The ARN of the API Gateway stage"
  value       = aws_api_gateway_stage.main.arn
}

output "root_resource_id" {
  description = "The ID of the resource at the '/' route of the API Gateway"
  value       = aws_api_gateway_rest_api.main.root_resource_id
}
