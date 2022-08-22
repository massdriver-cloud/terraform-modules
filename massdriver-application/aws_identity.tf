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

  # TODO: if local.is_aws && local.is_kubernetes
  # aws_eks_oidc_short = replace(var.kubernetes.cluster_artifact)
}

# TODO: work in eks support
# locals {
#   eks_oidc_short = replace(local.kubernetes_cluster.data.infrastructure.oidc_issuer_url, "https://", "")
# }



# resource "aws_iam_role" "application" {
#   name = module.k8s_application.params.md_metadata.name_prefix

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       "Sid"    = "EksCertManager"
#       "Effect" = "Allow",
#       "Principal" = {
#         "Federated" = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.eks_oidc_short}"
#       }
#       "Action" = "sts:AssumeRoleWithWebIdentity",
#       "Condition" = {
#         "StringEquals" = {
#           "${local.eks_oidc_short}:sub" = "system:serviceaccount:${module.k8s_application.params.namespace}:${module.k8s_application.params.md_metadata.name_prefix}"
#         }
#       }
#     }]
#   })
# }
