locals {
  split_role = split("/", module.application.id)
  role_name  = element(local.split_role, length(local.split_role) - 1)
}

module "application" {
  source  = "github.com/massdriver-cloud/terraform-modules//massdriver-application"
  name    = var.md_metadata.name_prefix
  service = "function"
}

resource "aws_lambda_function" "main" {
  function_name = var.md_metadata.name_prefix
  role          = module.application.id
  image_uri     = "${var.image.uri}:${var.image.tag}"
  package_type  = "Image"
  publish       = true
  memory_size   = var.memory_size
  timeout       = var.execution_timeout

  environment {
    variables = module.application.envs
  }

  dynamic "tracing_config" {
    for_each = var.x_ray_enabled ? [1] : []
    content {
      mode = "Active"
    }
  }
}

resource "aws_cloudwatch_log_group" "function_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.main.function_name}"
  retention_in_days = var.retention_days
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_iam_policy" "function_logging_policy" {
  name   = "${aws_lambda_function.main.function_name}-logging-policy"
  policy = <<EOF
{
  "Version" : "2012-10-17",
  "Statement" : [
    {
      "Action" : [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Effect" : "Allow",
      "Resource" : "${aws_cloudwatch_log_group.function_log_group.arn}"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "function_logging_policy_attachment" {
  role       = local.role_name
  policy_arn = aws_iam_policy.function_logging_policy.arn
}
