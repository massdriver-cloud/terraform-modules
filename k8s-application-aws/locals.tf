locals {
  connections       = jsondecode(file("connections.auto.tfvars.json"))
  params            = jsondecode(file("params.auto.tfvars.json"))
  k8s_cluster_name  = split("/", var.kubernetes_cluster.data.infrastructure.arn)[1]
  app_specification = yamldecode(file("${path.module}/../app.yaml"))

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

  region_hack = split(":", var.kubernetes_cluster.data.infrastructure.arn)[3]

  helm_additional_values = {
    aws = {
      securityGroup = {
        enabled = local.create_security_group
        id      = local.create_security_group ? aws_security_group.application.0.id : ""
      }
    }
    envs = concat(
      local.params.envs,
      local.result_envs
    )
    ingress = {
      className = "nginx" // eventually this should come from the kubernetes artifact
      annotations = {
        "cert-manager.io/cluster-issuer" : "letsencrypt-prod"     // eventually this should come from kubernetes artifact
        "nginx.ingress.kubernetes.io/force-ssl-redirect" = "true" // hardcoding this for now, dependent on nginx
      }
    }
    serviceAccount = {
      annotations = {
        "eks.amazonaws.com/role-arn" = aws_iam_role.application.arn
      }
    }
  }
}
