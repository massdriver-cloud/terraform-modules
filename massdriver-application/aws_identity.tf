locals {
  aws_service_map = {
    function   = "lambda",
    vm         = "ec2",
    kubernetes = "eks"
  }

  aws_service                      = local.aws_service_map[var.service]
  aws_eks_oidc_short               = local.is_aws && local.is_kubernetes ? replace(var.kubernetes.cluster_artifact.data.infrastructure.oidc_issuer_url, "https://", "") : null
  aws_eks_oidc_federated_principal = local.is_aws && local.is_kubernetes ? "arn:aws:iam::${data.mdxc_cloud.current.id}:oidc-provider/${local.aws_eks_oidc_short}" : null
  aws_eks_assume_role_conditional  = local.is_aws && local.is_kubernetes ? "system:serviceaccount:${var.kubernetes.namespace}:${var.name}" : null

  aws_identity = {
    assume_role_policy = local.is_kubernetes ? local.aws_federated_principal_assume_role : local.aws_service_principal_assume_role
  }

  aws_service_principal_assume_role = !local.is_aws ? null : <<EOF
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

  aws_federated_principal_assume_role = !local.is_aws ? null : <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Principal": {
        "Federated": "${local.aws_eks_oidc_federated_principal}"
      },
      "Condition": {
        "StringEquals": {
          "${local.aws_eks_oidc_short}:sub": "${local.aws_eks_assume_role_conditional}"
        }
      }
    }
  ]
}
EOF

}
