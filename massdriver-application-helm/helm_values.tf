locals {
  helm_values = {
    commonLabels = module.massdriver_helm_values.common_labels
    pod = {
      annotations = {
        "md-deployment-id" = module.massdriver_helm_values.deployment_id
      }
    }
    envs = [for key, val in local.combined_envs : { name = key, value = tostring(val) }]
    ingress = {
      className = "nginx" // TODO: eventually this should come from the kubernetes artifact
      annotations = {
        "cert-manager.io/cluster-issuer" : "letsencrypt-prod"     // TODO: eventually this should come from kubernetes artifact
        "nginx.ingress.kubernetes.io/force-ssl-redirect" = "true" // TODO: hardcoding this for now, dependent on nginx
      }
    }
    serviceAccount = module.massdriver_helm_values.k8s_service_account
  }
}

module "massdriver_helm_values" {
  source                 = "github.com/massdriver-cloud/terraform-modules//massdriver-helm-values?ref=4b8d47a"
  massdriver_application = module.application
}
