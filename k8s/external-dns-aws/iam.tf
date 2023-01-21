locals {
  # This needs to match the SA name in the submodule
  service_account_name = var.release == "external-dns" ? "external-dns" : "${var.release}-external-dns"
  eks_oidc_short       = replace(var.kubernetes_cluster.data.infrastructure.oidc_issuer_url, "https://", "")
  domain_filters       = join(",", concat([for zone, name in var.route53_hosted_zones : name], []))
}


data "aws_arn" "eks_cluster" {
  arn = var.kubernetes_cluster.data.infrastructure.arn
}

resource "aws_iam_role" "external-dns" {
  name = "${var.md_metadata.name_prefix}-externaldns"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      "Sid"    = "EksExternalDns"
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
    name = "external-dns"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          "Effect" = "Allow",
          "Action" = [
            "route53:ChangeResourceRecordSets"
          ],
          "Resource" = [for zone, name in var.route53_hosted_zones : "arn:aws:route53:::hostedzone/${zone}"]
        },
        {
          "Effect" = "Allow",
          "Action" = [
            "route53:ListHostedZones",
            "route53:ListResourceRecordSets"
          ],
          "Resource" = [
            "*"
          ]
        }
      ]
    })
  }
}
