locals {
  # TODO: check real versions
  version_to_parameter_group = {
    "2.8" = "default.memcached2.8"
    "3.2" = "default.memcached3.2"
    "4.0" = "default.memcached4.0"
    "5.0" = "default.memcached5.0"
    "6.x" = "default.memcached6.x"
  }

  # TODO
  version_to_engine_version = {
    "2.8" = "2.8.24"
    "3.2" = "3.2.10"
    "4.0" = "4.0.10"
    "5.0" = "5.0.6"
    "6.x" = "6.x"
  }

  subnet_ids = {
    "internal" = [for subnet in var.internal_subnets : element(split("/", subnet["arn"]), 1)]
    "private" = [for subnet in var.private_subnets : element(split("/", subnet["arn"]), 1)]
  }
}

resource "aws_security_group" "main" {
  name_prefix = "${var.md_metadata.name_prefix}-"
  description = "For Elasticache cluster ${var.md_metadata.name_prefix}"
  vpc_id      = element(split("/", var.vpc_id), 1)
}

resource "aws_elasticache_subnet_group" "main" {
  name        = var.md_metadata.name_prefix
  description = "For Elasticache cluster ${var.md_metadata.name_prefix}"
  subnet_ids  = local.subnet_ids[var.subnet_type]
}

resource "random_password" "auth" {
  count   = var.secure ? 1 : 0
  length  = 64
  special = false
}

resource "aws_elasticache_cluster" "main" {
  apply_immediately    = true
  cluster_id           = module.this.id
  engine               = "memcached"
  engine_version       = var.memcached_version
  node_type            = var.node_type
  num_cache_nodes      = var.num_nodes
  parameter_group_name = join("", aws_elasticache_parameter_group.default.*.name)
  subnet_group_name = aws_elasticache_subnet_group.main.name
  # It would be nice to remove null or duplicate security group IDs, if there are any, using `compact`,
  # but that causes problems, and having duplicates does not seem to cause problems.
  # See https://github.com/hashicorp/terraform/issues/29799
  security_group_ids = [aws_security_group.main.id]
  maintenance_window           = var.maintenance_window
  notification_topic_arn       = var.notification_topic_arn
  port                         = var.port
  az_mode                      = var.az_mode
  availability_zone            = var.availability_zone
  preferred_availability_zones = var.availability_zones
  tags                         = var.md_metadata.name_prefix
}

resource "aws_security_group_rule" "vpc_ingress" {
  count = 1

  description = "From allowed CIDRs"

  type        = "ingress"
  from_port   = element(concat(aws_elasticache_cluster.main.*.port, [""]), 0)
  to_port     = element(concat(aws_elasticache_cluster.main.*.port, [""]), 0)
  protocol    = "tcp"
  cidr_blocks = [var.vpc.data.infrastructure.cidr]

  security_group_id = aws_security_group.main.id
}
