module "external-dns" {
  source             = "../k8s-external-dns"
  md_metadata        = var.md_metadata
  kubernetes_cluster = var.kubernetes_cluster
  release            = var.release
  namespace          = var.namespace
  domain_filters     = join(",", concat([for zone, name in var.route53_hosted_zones : name], []))
  helm_additional_values = merge({
    serviceAccount = {
      annotations = {
        "eks.amazonaws.com/role-arn" = aws_iam_role.external-dns.arn
      }
    }
  }, var.helm_additional_values)
  dns_provider = "aws"
}
