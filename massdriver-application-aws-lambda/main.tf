locals {
  split_role = split("/", module.application.identity)
  role_name  = element(local.split_role, length(local.split_role) - 1)
}

module "application" {
  source  = "github.com/massdriver-cloud/terraform-modules//massdriver-application?ref=61a38e9"
  name    = var.md_metadata.name_prefix
  service = "function"
}

module "aws_lambda_function" {
  source            = "github.com/massdriver-cloud/terraform-modules//aws/aws-lambda-function?ref=61a38e9"
  function_name     = var.md_metadata.name_prefix
  role_arn          = module.application.identity
  image             = var.image
  memory_size       = var.memory_size
  execution_timeout = var.execution_timeout
  envs              = module.application.envs
  x_ray_enabled     = var.x_ray_enabled
  retention_days    = var.retention_days
}
