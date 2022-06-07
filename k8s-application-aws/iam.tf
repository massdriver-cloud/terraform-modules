locals {
  eks_oidc_short = replace(var.kubernetes_cluster.data.infrastructure.oidc_issuer_url, "https://", "")

  // build a list of which connections need IAM policies, and the name of the policy: [{"connection": <connection_name>, "policy": <policy_name>},...]
  dependency_to_policy_map = [for dep_name, dep_spec in local.app_specification.dependencies : { "dependency" = dep_name, "policy" = lookup(dep_spec, "policy", null) } if lookup(dep_spec, "policy", "") != ""]
  // turn the above list into an actual list of IAM policy ARNs
  merged_policies = [for dep2pol in local.dependency_to_policy_map : lookup(local.connections, dep2pol.dependency, null)["data"]["security"]["policies"][dep2pol.policy]]

  service_account_annotations = {
    "eks.amazonaws.com/role-arn" = aws_iam_role.application.arn
  }
}

data "aws_arn" "eks_cluster" {
  arn = var.kubernetes_cluster.data.infrastructure.arn
}

data "aws_caller_identity" "current" {}

resource "aws_iam_role" "application" {
  name = var.md_metadata.name_prefix

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      "Sid"    = "EksCertManager"
      "Effect" = "Allow",
      "Principal" = {
        "Federated" = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.eks_oidc_short}"
      }
      "Action" = "sts:AssumeRoleWithWebIdentity",
      "Condition" = {
        "StringEquals" = {
          "${local.eks_oidc_short}:sub" = "system:serviceaccount:${var.namespace}:${var.name}"
        }
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "policies" {
  for_each   = toset(local.merged_policies)
  role       = aws_iam_role.application.name
  policy_arn = each.key
}

