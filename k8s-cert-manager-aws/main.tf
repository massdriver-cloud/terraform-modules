module "cert-manager" {
  source             = "../k8s-cert-manager"
  md_metadata        = var.md_metadata
  kubernetes_cluster = var.kubernetes_cluster
  release            = var.release
  namespace          = var.namespace
  helm_additional_values = {
    serviceAccount = {
      annotations = {
        "eks.amazonaws.com/role-arn" = aws_iam_role.cert-manager.arn
      }
    }
  }
}
