locals {
  cloud            = var.kubernetes_cluster.specs.kubernetes.cloud
  opensearch = {
    image_version = "2.1.0"
    chart_version = "2.3.0"
    # this should be the default calculated name anyway, but we want to enforce it just to be sure
    release_name = var.release == "" || var.release == "opensearch" ? "opensearch" : "${var.release}-opensearch"
  }
  helm_values = {
    rbac = {
      create = true
      serviceAccountName = local.opensearch.release_name
    }
    image = {
      tag = local.opensearch.image_version
    }
    labels = var.md_metadata.default_tags
    // see: https://github.com/opensearch-project/helm-charts/blob/main/charts/opensearch/values.yaml#L373-L391
    lifecyle = length(var.ism_policies) > 0 ? {
      preStop = {
          exec = {
            command: ["/bin/sh", "-c", "echo Hello from the postStart handler > /usr/share/message"]
          }
      }
      postStart = {
          exec = {
            command = [
                "bash",
                "-c",
                <<EOF
                #!/bin/bash
                ES_URL=http://localhost:9200
                # wait for ES to be up
                while [[ "$(curl -s -o /dev/null -w '%\{http_code\}\n' $ES_URL)" != "200" ]]; do sleep 1; done
                # PUT an ISM policy to ES rest API for each one in the var.ism_policies map
                ${join("\n", [for k, v in var.ism_policies: "curl -XPUT \"$ES_URL/_template/${k}\" -H 'Content-Type: application/json' -d '${v}'"])}
                EOF
            ]
          }
      }
    } : {}
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
    # GKE does note support unsafe kernel parameters in kubelet so requires a privledged init container to set them
    # we want to avoid doing this in other clouds as it is not a security best practice.
    local.cloud == "gcp" ? "${file("${path.module}/gke_sysctl_values.yaml")}" : "${file("${path.module}/sysctl_values.yaml")}",
    yamlencode(local.helm_values),
    yamlencode(var.helm_additional_values),
  ]
}
