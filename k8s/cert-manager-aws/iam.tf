locals {
  eks_oidc_short       = replace(var.kubernetes_cluster.data.infrastructure.oidc_issuer_url, "https://", "")
  service_account_name = var.release == "cert-manager" ? "cert-manager" : "${var.release}-cert-manager"
}

data "aws_arn" "eks_cluster" {
  arn = var.kubernetes_cluster.data.infrastructure.arn
}

resource "aws_iam_role" "cert-manager" {
  name = "${var.md_metadata.name_prefix}-certmanager"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      "Sid"    = "EksCertManager"
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
    name = "cert-manager"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          "Effect"   = "Allow",
          "Action"   = "route53:GetChange",
          "Resource" = "arn:aws:route53:::change/*"
        },
        {
          "Effect" = "Allow",
          "Action" = [
            "route53:ChangeResourceRecordSets",
            "route53:ListResourceRecordSets"
          ],
          "Resource" = [for zone, name in var.route53_hosted_zones : "arn:aws:route53:::hostedzone/${zone}"]
        },
        {
          "Effect"   = "Allow",
          "Action"   = "route53:ListHostedZonesByName",
          "Resource" = "*"
        }
      ]
    })
  }
}
