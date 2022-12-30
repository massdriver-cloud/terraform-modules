
locals {
  data_infrastructure = {
    grn = data.google_container_cluster.cluster.id
  }

  data_authentication = {
    cluster = {
      server                     = local.cluster_host
      certificate-authority-data = data.google_container_cluster.cluster.master_auth.0.cluster_ca_certificate
    }
    user = {
      token = lookup(data.kubernetes_secret.massdriver-cloud-provisioner_service-account_secret.data, "token")
    }
  }

  specs_kubernetes = {
    cloud            = "gcp"
    distribution     = "gke"
    version          = split("-", data.google_container_cluster.cluster.master_version)[0]
    platform_version = split("-", data.google_container_cluster.cluster.master_version)[1]
  }

  kubernetes_cluster_artifact = {
    data = {
      infrastructure = local.data_infrastructure
      authentication = local.data_authentication
    }
    specs = {
      kubernetes = local.specs_kubernetes
    }
  }
}

resource "massdriver_artifact" "kubernetes_cluster" {
  field                = "kubernetes_cluster"
  provider_resource_id = data.google_container_cluster.cluster.id
  name                 = "GKE Cluster Credentials ${var.md_metadata.name_prefix} [${var.subnetwork.specs.gcp.region}]"
  artifact             = jsonencode(local.kubernetes_cluster_artifact)
}
