locals {
  create_privatelink = true
}

resource "mongodbatlas_privatelink_endpoint" "main" {
  count         = local.create_privatelink ? 1 : 0
  project_id    = mongodbatlas_project.main.id
  provider_name = "AWS"
  region        = local.mongo_region
}

resource "mongodbatlas_privatelink_endpoint_service" "main" {
  count               = local.create_privatelink ? 1 : 0
  depends_on          = [time_sleep.wait_30_seconds]
  project_id          = mongodbatlas_privatelink_endpoint.main.0.project_id
  private_link_id     = mongodbatlas_privatelink_endpoint.main.0.private_link_id
  endpoint_service_id = aws_vpc_endpoint.main.0.id
  provider_name       = "AWS"
}

resource "aws_vpc_endpoint" "main" {
  count              = local.create_privatelink ? 1 : 0
  vpc_id             = var.vpc_id
  service_name       = mongodbatlas_privatelink_endpoint.main.0.endpoint_service_name
  vpc_endpoint_type  = "Interface"
  subnet_ids         = var.subnet_ids
  security_group_ids = [aws_security_group.main.0.id]
}

resource "aws_security_group" "main" {
  count       = local.create_privatelink ? 1 : 0
  name        = var.name
  description = "Control traffic for ${var.name} mongodb atlas cluster"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "allow_all_egress" {
  count             = local.create_privatelink ? 1 : 0
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.main.0.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "time_sleep" "wait_30_seconds" {
  count           = local.create_privatelink ? 1 : 0
  create_duration = "30s"

  depends_on = [
    aws_vpc_endpoint.main
  ]
}
