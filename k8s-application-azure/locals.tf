locals {
  connections       = jsondecode(file("connections.auto.tfvars.json"))
  params            = jsondecode(file("params.auto.tfvars.json"))
  app_specification = yamldecode(file("${path.module}/../app.yaml"))

  kubernetes_cluster_split_ari = split("/", var.kubernetes_cluster.data.infrastructure.ari)
  kubernetes_cluster_name      = local.kubernetes_cluster_split_ari[index(local.kubernetes_cluster_split_ari, "managedClusters") + 1]
  resource_group_name          = local.kubernetes_cluster_split_ari[index(local.kubernetes_cluster_split_ari, "resourceGroups") + 1]

  helm_chart_switch = {
    "simple" : "application"
    "custom" : "../chart"
    //"remote???": local.app_specification.deployment.chart
  }
  helm_repository_switch = {
    "simple" : "https://massdriver-cloud.github.io/helm-charts"
    "custom" : ""
    //"remote???": local.app_specification.deployment.repository
  }
  helm_chart      = local.helm_chart_switch[local.app_specification.deployment.type]
  helm_repository = local.helm_repository_switch[local.app_specification.deployment.type]

  helm_additional_values = {
    envs = concat(
      local.params.envs,
      local.dependency_envs,
      local.service_principal_envs
    )
    ingress = {
      className = "nginx" // eventually this should come from the kubernetes artifact
      annotations = {
        "cert-manager.io/cluster-issuer" : "letsencrypt-prod"     // eventually this should come from kubernetes artifact
        "nginx.ingress.kubernetes.io/force-ssl-redirect" = "true" // hardcoding this for now, dependent on nginx
      }
    }
  }
}
