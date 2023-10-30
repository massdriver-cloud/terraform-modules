locals {
  # this should be the default calculated name anyway, but we want to enforce it just to be sure
  service_account_name = var.release == "${local.cloud}-cluster-autoscaler" ? "${local.cloud}-cluster-autoscaler" : "${var.release}-cluster-autoscaler"

  # extract data about kubernetes cluster
  cloud = var.kubernetes_cluster.specs.kubernetes.cloud

  # AWS Specific locals
  eks_oidc_short   = replace(var.kubernetes_cluster.data.infrastructure.oidc_issuer_url, "https://", "")
  eks_cluster_name = split("/", data.aws_arn.eks_cluster.resource)[1]

  // Eventually this is probably passed in by the cloud and not done here
  helm_additional_values = {
    rbac = {
      serviceAccount = {
        annotations = {
          "eks.amazonaws.com/role-arn" = aws_iam_role.cluster-autoscaler.arn
        }
        name = local.service_account_name
      }
    }
    autoDiscovery = {
      clusterName = local.eks_cluster_name
    }
    awsRegion = data.aws_arn.eks_cluster.region
  }
}

data "aws_arn" "eks_cluster" {
  arn = var.kubernetes_cluster.data.infrastructure.arn
}

resource "aws_iam_role" "cluster-autoscaler" {
  name = substr("${var.md_metadata.name_prefix}-clusterautoscaler", 0, 64)

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      "Sid"    = "EKSClusterAutoscaler"
      "Effect" = "Allow",
      "Principal" = {
        "Federated" = "arn:aws:iam::${data.aws_arn.eks_cluster.account}:oidc-provider/${local.eks_oidc_short}"
      }
      "Action" = "sts:AssumeRoleWithWebIdentity",
      "Condition" = {
        "StringEquals" = {
          "${local.eks_oidc_short}:sub" = "system:serviceaccount:${var.namespace}:${local.service_account_name}"
        }
      }
    }]
  })

  inline_policy {
    name = "cluster-autoscaler"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          "Action" = [
            "autoscaling:DescribeAutoScalingGroups",
            "autoscaling:DescribeAutoScalingInstances",
            "autoscaling:DescribeLaunchConfigurations",
            "autoscaling:DescribeScalingActivities",
            "autoscaling:DescribeTags",
            "ec2:DescribeInstanceTypes",
            "ec2:DescribeLaunchTemplateVersions"
          ],
          Resource = "*"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "autoscaling:SetDesiredCapacity",
            "autoscaling:TerminateInstanceInAutoScalingGroup",
            "ec2:DescribeImages",
            "ec2:GetInstanceTypesFromInstanceRequirements",
            "eks:DescribeNodegroup"
          ],
          "Resource" : "*",
          "Condition" : {
            "StringEquals" : {
              "autoscaling:ResourceTag/k8s.io/cluster-autoscaler/enabled" : "true",
              "autoscaling:ResourceTag/kubernetes.io/cluster/${local.eks_cluster_name}" : "owned"
            }
          }
        }
      ]
    })
  }
}
