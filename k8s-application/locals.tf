locals {
  # directory structure
  # application/
  #   massdriver.yaml
  #   chart/
  #   src/
  #     path.root is from this context
  #     connections.auto.tfvars.json
  #     params.auto.tfvars.json
  #     main.tf
  app_specification = yamldecode(file("${path.root}/../massdriver.yaml"))
  connections       = jsondecode(file("${path.root}/connections.auto.tfvars.json"))
  params            = jsondecode(file("${path.root}/params.auto.tfvars.json"))
  app_block         = lookup(local.app_specification, "app", {})

  helm_additional_values = {
    envs = concat(
      lookup(local.params, "envs", []),
      local.result_envs
    )
    ingress = {
      className = "nginx" // eventually this should come from the kubernetes artifact
      annotations = {
        "cert-manager.io/cluster-issuer" : "letsencrypt-prod"     // eventually this should come from kubernetes artifact
        "nginx.ingress.kubernetes.io/force-ssl-redirect" = "true" // hardcoding this for now, dependent on nginx
      }
    }
  }
  helm_additional_values_gcp = mdxc_application_identity.main.cloud == "gcp" ? {
    serviceAccount = {
      annotations = {
        "iam.gke.io/gcp-service-account" = (mdxc_application_identity.main).gcp_application_identity.service_account_email
      }
    }
  } : {}
}
