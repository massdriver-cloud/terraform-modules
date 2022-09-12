
locals {
  eks_oidc_short = replace(var.kubernetes_cluster.data.infrastructure.oidc_issuer_url, "https://", "")
  iam_resources  = length(var.storage_class_to_efs_arn_map) > 0 ? [for sc_name, efs_arn in var.storage_class_to_efs_arn_map : efs_arn] : ["*"]
}

data "aws_arn" "eks_cluster" {
  arn = var.kubernetes_cluster.data.infrastructure.arn
}

resource "aws_iam_role" "efs_csi_controller" {
  name = "${var.md_metadata.name_prefix}-efs-csi-controller"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      "Sid"    = "EksIrsa"
      "Effect" = "Allow",
      "Principal" = {
        "Federated" = "arn:aws:iam::${data.aws_arn.eks_cluster.account}:oidc-provider/${local.eks_oidc_short}"
      }
      "Action" = "sts:AssumeRoleWithWebIdentity",
      "Condition" = {
        "StringEquals" = {
          "${local.eks_oidc_short}:sub" = "system:serviceaccount:${var.namespace}:${local.controller_service_account_name}"
        }
      }
    }]
  })

  inline_policy {
    name = "efs-csi-controller"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          "Effect" = "Allow",
          "Action" = [
            "elasticfilesystem:DescribeAccessPoints",
            "elasticfilesystem:DescribeFileSystems",
            "elasticfilesystem:DescribeMountTargets",
            "ec2:DescribeAvailabilityZones",
          ],
          "Resource" = local.iam_resources
        },
        {
          "Effect" = "Allow",
          "Action" = [
            "elasticfilesystem:CreateAccessPoint"
          ],
          "Resource" = local.iam_resources
          "Condition" : {
            "StringLike" : {
              "aws:RequestTag/efs.csi.aws.com/cluster" : "true"
            }
          }
        },
        {
          "Effect" = "Allow",
          "Action" = [
            "elasticfilesystem:DeleteAccessPoint",
          ]
          "Resource" = local.iam_resources
          "Condition" : {
            "StringEquals" : {
              "aws:ResourceTag/efs.csi.aws.com/cluster" : "true"
            }
          }
        }
      ]
    })
  }
}
