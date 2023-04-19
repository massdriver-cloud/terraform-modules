output "identity" {
  description = "Cloud ID for application IAM. For AWS this is an IAM Role ARN."
  value       = module.application.id
}
