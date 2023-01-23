
data "aws_eks_addon_version" "ebs_csi_driver" {
  addon_name         = "aws-ebs-csi-driver"
  kubernetes_version = var.kubernetes_version
  most_recent        = true
}

resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name  = local.cluster_name
  addon_name    = "aws-ebs-csi-driver"
  addon_version = data.aws_eks_addon_version.ebs_csi_driver.version

  // Hardcoding this to "NONE" since "OVERWRITE" is dangerous and "PRESERVE" fails on create: https://github.com/hashicorp/terraform-provider-aws/issues/27481
  resolve_conflicts        = "NONE"
  service_account_role_arn = aws_iam_role.ebs_csi_driver.arn
}
