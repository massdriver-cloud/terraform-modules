locals {
  aws_service_map = {
    function   = "lambda",
    vm         = "ec2",
    kubernetes = "eks"
  }

  aws_service = local.aws_service_map[var.service]

  non_eks_assume_role_policy = <<EOF
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

  aws_identity = {
    assume_role_policy = local.non_eks_assume_role_policy
  }
  aws_tmp = {
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
						"ec2.amazonaws.com"
					]
				}
			}
		]
	}
   EOF
  }
}

# TODO: work in eks support
# locals {
#   eks_oidc_short = replace(local.kubernetes_cluster.data.infrastructure.oidc_issuer_url, "https://", "")
# }

# data "aws_caller_identity" "current" {}

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
