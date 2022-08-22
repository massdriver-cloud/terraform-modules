locals {
  aws_service_map = {
    function   = "lambda",
    vm         = "ec2",
    kubernetes = "eks"
  }

  aws_service = local.aws_service_map[var.service]

  aws_identity = {
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "sts:AssumeRole"
      ],
      "Principal": {
        "Service": [
          "${local.aws_service}.amazonaws.com"
        ]
      }
    }
  ]
}
EOF
  }

  aws_eks_oidc_short               = local.is_aws && local.is_kubernetes ? replace(var.kubernetes.cluster_artifact.data.infrastructure.oidc_issuer_url, "https://", "") : null
  aws_eks_oidc_federated_principal = local.is_aws && local.is_kubernetes ? "arn:aws:iam::${data.mdxc_cloud.current.id}:oidc-provider/${local.eks_oidc_short}" : null
  aws_eks_assume_role_conditional  = local.is_aws && local.is_kubernetes ? "system:serviceaccount:${var.kubernetes.namespace}:${var.name}" : null
}


# resource "aws_iam_role" "application" {
#   name = module.k8s_application.params.md_metadata.name_prefix

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       "Sid"    = "EksCertManager"
#       "Effect" = "Allow",
#       "Principal" = {
#         "Federated" = "arn:aws:iam::${data.mdxc_cloud.current.id}:oidc-provider/${local.eks_oidc_short}"
#       }
#       "Action" = "sts:AssumeRoleWithWebIdentity",
#       "Condition" = {
#         "StringEquals" = {
#           "${local.eks_oidc_short}:sub" = "system:serviceaccount:${var.kubernetes.namespace}:${var.name}"
#         }
#       }
#     }]
#   })
# }
