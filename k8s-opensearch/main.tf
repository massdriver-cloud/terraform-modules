locals {
  opensearch = {
    image_version = "2.1.0"
    chart_version = "2.3.0"
    # this should be the default calculated name anyway, but we want to enforce it just to be sure
    release_name = var.release == "" ? "opensearch" : "${var.release}-opensearch"
  }
  helm_values = {
    rbac = {
      serviceAccountName = local.opensearch.release_name
    }
    image = {
      tag = local.opensearch.image_version
    }
    labels = var.md_metadata.default_tags
  }
}

resource "helm_release" "opensearch" {
  name             = local.opensearch.release_name
  chart            = "opensearch"
  repository       = "https://opensearch-project.github.io/helm-charts/"
  version          = local.opensearch.chart_version
  namespace        = var.namespace
  create_namespace = true
  wait_for_jobs    = true

  values = [
    "${file("${path.module}/opensearch_values.yaml")}",
    yamlencode(local.helm_values),
    yamlencode(var.helm_additional_values)
  ]
}
