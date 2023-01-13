locals {
  version_to_parameter_group = {
    "2.8" = "default.redis2.8"
    "3.2" = "default.redis3.2"
    "4.0" = "default.redis4.0"
    "5.0" = "default.redis5.0"
    "6.x" = "default.redis6.x"
  }

  version_to_engine_version = {
    "2.8" = "2.8.24"
    "3.2" = "3.2.10"
    "4.0" = "4.0.10"
    "5.0" = "5.0.6"
    "6.x" = "6.x"
  }

  subnet_ids = {
    "internal" = [for subnet in var.vpc.data.infrastructure.internal_subnets : element(split("/", subnet["arn"]), 1)]
    "private" = [for subnet in var.vpc.data.infrastructure.private_subnets : element(split("/", subnet["arn"]), 1)]
  }
}


resource "aws_security_group" "main" {
  name_prefix = "${var.md_metadata.name_prefix}-"
  description = "For Elasticache cluster ${var.md_metadata.name_prefix}"
  vpc_id      = element(split("/", var.vpc.data.infrastructure.arn), 1)
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

resource "aws_elasticache_replication_group" "main" {
  replication_group_id = var.md_metadata.name_prefix
  description          = var.md_metadata.name_prefix

  port           = 6379
  engine         = "elasticache"
  engine_version = local.version_to_engine_version[var.redis_version]
  node_type      = var.node_type

  subnet_group_name = aws_elasticache_subnet_group.main.name

  security_group_ids = [aws_security_group.main.id]

  apply_immediately          = true
  at_rest_encryption_enabled = true
  auto_minor_version_upgrade = true # this only applies to cluster 6.x and up
  automatic_failover_enabled = var.cluster_mode_enabled || var.replicas > 0
  multi_az_enabled           = var.cluster_mode_enabled || var.replicas > 0
  snapshot_retention_limit   = 7
  snapshot_window            = "07:00-08:00"
  final_snapshot_identifier  = "${var.md_metadata.name_prefix}-${formatdate("YYMMDDhhmmss", timestamp())}"

  # security
  auth_token                 = var.secure ? random_password.auth[0].result : null
  transit_encryption_enabled = var.secure

  # this variable only matters for non-clustered instances. We need to add one to replicas for the primary instance.
  num_cache_clusters = var.cluster_mode_enabled ? null : var.replicas + 1
  # these variables only matter for clustered instances
  replicas_per_node_group = var.cluster_mode_enabled ? var.replicas : null
  num_node_groups         = var.cluster_mode_enabled ? var.node_groups : null

  # if this is a clustered instance, we need to include ".cluster.on" to the parameter group name
  parameter_group_name = "${local.version_to_parameter_group[var.redis_version]}${var.cluster_mode_enabled ? ".cluster.on" : ""}"
}

resource "aws_security_group_rule" "vpc_ingress" {
  count = 1

  description = "From allowed CIDRs"

  type        = "ingress"
  from_port   = element(concat(aws_elasticache_replication_group.main.*.port, [""]), 0)
  to_port     = element(concat(aws_elasticache_replication_group.main.*.port, [""]), 0)
  protocol    = "tcp"
  cidr_blocks = [var.vpc.data.infrastructure.cidr]

  security_group_id = aws_security_group.main.id
}
