locals {
  merged_security_groups = jsondecode(data.jq_query.security_groups.result)
  create_security_group  = length(local.merged_security_groups) > 0
}

data "jq_query" "security_groups" {
  data  = jsonencode(local.connections)
  query = "[keys[] as $connection | .[$connection].data.security.groups as $groups | $groups | select(. != null) | to_entries[] | {key:($connection + \"_\" + .key), value:.value}] | from_entries"
}

data "aws_eks_cluster" "eks_cluster" {
  name = split("/", var.kubernetes_cluster.data.infrastructure.arn)[1]
}

resource "aws_security_group" "application" {
  count       = local.create_security_group ? 1 : 0
  name        = var.md_metadata.name_prefix
  description = "Security group for ${var.md_metadata.name_prefix}"
  vpc_id      = data.aws_eks_cluster.eks_cluster.vpc_config.0.vpc_id
}

resource "aws_security_group_rule" "rules" {
  for_each                 = local.merged_security_groups
  security_group_id        = split("/", each.value.arn)[1]
  type                     = "ingress"
  from_port                = each.value.port
  to_port                  = each.value.port
  protocol                 = each.value.protocol
  source_security_group_id = aws_security_group.application.0.id
}

resource "aws_security_group_rule" "pod_ingress" {
  count             = local.create_security_group ? 1 : 0
  security_group_id = aws_security_group.application.0.id
  type              = "ingress"
  from_port         = 0
  to_port           = 65536
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
}