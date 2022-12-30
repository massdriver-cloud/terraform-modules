locals {
  enable_opensearch       = var.logging.opensearch.enabled
  enable_fluentbit        = local.enable_opensearch # we could add OR logic for other destinations that would require fluentbit
  observability_namespace = "md-observability"
}

module "kube-state-metrics" {
  source      = "github.com/massdriver-cloud/terraform-modules//k8s-kube-state-metrics?ref=c336d59"
  md_metadata = var.md_metadata
  release     = "kube-state-metrics"
  namespace   = local.observability_namespace
}

module "opensearch" {
  count              = local.enable_opensearch ? 1 : 0
  source             = "github.com/massdriver-cloud/terraform-modules//k8s-opensearch?ref=5fc9525"
  md_metadata        = var.md_metadata
  release            = "opensearch"
  namespace          = local.observability_namespace
  kubernetes_cluster = var.kubernetes_cluster_artifact
  helm_additional_values = {
    persistence = {
      size = "${var.logging.opensearch.persistence_size_gi}Gi"
    }
  }
  enable_dashboards = true
  // this adds a retention policy to move indexes to warm after 1 day and delete them after a user configurable number of days
  ism_policies = {
    "hot-warm-delete" : templatefile("${path.module}/logging/opensearch/ism_hot_warm_delete.json.tftpl", { "log_retention_days" : var.logging.opensearch.retention_days })
  }
}

module "fluentbit" {
  count              = local.enable_fluentbit ? 1 : 0
  source             = "github.com/massdriver-cloud/terraform-modules//k8s-fluentbit?ref=f920d78"
  md_metadata        = var.md_metadata
  release            = "fluentbit"
  namespace          = local.observability_namespace
  kubernetes_cluster = var.kubernetes_cluster_artifact
  helm_additional_values = {
    config = {
      filters = file("${path.module}/logging/fluentbit/filter.conf")
      outputs = templatefile("${path.module}/logging/fluentbit/opensearch_output.conf.tftpl", {
        namespace = local.observability_namespace
      })
    }
  }
}
