locals {
  dashboards = {
    image_version = "2.1.0"
    chart_version = "2.2.4"
    # this should be the default calculated name anyway, but we want to enforce it just to be sure
    release_name = "${local.opensearch.release_name}-dashboards"
  }
  dashboards_helm_values = {
    serviceAccount = {
      name = local.dashboards.release_name
    }
    image = {
      tag = local.dashboards.image_version
    }
    labels = var.md_metadata.default_tags
  }
}

resource "helm_release" "dashboards" {
  count            = var.enable_dashboards ? 1 : 0
  name             = local.dashboards.release_name
  chart            = "opensearch-dashboards"
  repository       = "https://opensearch-project.github.io/helm-charts/"
  version          = local.dashboards.chart_version
  namespace        = var.namespace
  create_namespace = true
  wait_for_jobs    = true

  values = [
    "${file("${path.module}/opensearch_dashboards_values.yaml")}",
    yamlencode(local.dashboards_helm_values),
    yamlencode(var.helm_additional_values)
  ]
}
