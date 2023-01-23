locals {
  eks_oidc_short = replace(var.eks_oidc_issuer_url, "https://", "")
  cluster_name   = element(split("/", data.aws_arn.eks_cluster.resource), 1)

  // namespace, service_account_name and policy from https://docs.aws.amazon.com/eks/latest/userguide/csi-iam-role.html
  namespace             = "kube-system"
  service_account_name  = "ebs-csi-controller-sa"
  ebs_csi_driver_policy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

data "aws_arn" "eks_cluster" {
  arn = var.eks_cluster_arn
}

resource "aws_iam_role" "ebs_csi_driver" {
  name = "${local.cluster_name}-ebs-csi-driver"

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
          "${local.eks_oidc_short}:sub" = "system:serviceaccount:${local.namespace}:${local.service_account_name}"
        }
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ebs_csi_driver" {
  role       = aws_iam_role.ebs_csi_driver.name
  policy_arn = local.ebs_csi_driver_policy
}
