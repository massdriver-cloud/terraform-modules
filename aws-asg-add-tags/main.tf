
locals {
  asg_names   = [for ng in data.aws_eks_node_group.main : [for res in ng.resources : res.autoscaling_groups[0].name][0]]
  asg_tag_map = [for name in local.asg_names : { for tag, tag_v in var.tags : "${name}-${tag}" => { "asg" = name, "key" = tag, "value" = tag_v } }][0]
}

data "aws_eks_node_groups" "main" {
  cluster_name = var.cluster_name
}

data "aws_eks_node_group" "main" {
  for_each        = data.aws_eks_node_groups.main.names
  cluster_name    = var.cluster_name
  node_group_name = each.value
}

# https://github.com/terraform-aws-modules/terraform-aws-eks/issues/860
# the cross product of all node groups and all tags
resource "null_resource" "add_custom_tags_to_asg" {
  for_each = local.asg_tag_map
  triggers = {
    node_group = join(",", data.aws_eks_node_groups.main.names)
  }
  provisioner "local-exec" {
    command = <<EOF
aws autoscaling create-or-update-tags \
  --tags ResourceId=${each.value.asg},ResourceType=auto-scaling-group,Key=${each.value.key},Value=${each.value.value},PropagateAtLaunch=true
EOF
  }
}

