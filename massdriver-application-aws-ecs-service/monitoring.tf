locals {
  logging_options = {
    awslogs = {
      awslogs-group         = aws_cloudwatch_log_group.logs.0.name
      awslogs-region        = local.region
      awslogs-stream-prefix = var.md_metadata.name_prefix
    }
  }
}

resource "aws_cloudwatch_log_group" "logs" {
  count             = var.logging.driver == "awslogs" ? 1 : 0
  name              = "ecs/${var.md_metadata.name_prefix}"
  retention_in_days = lookup(var.logging, "retention", 0)
}
