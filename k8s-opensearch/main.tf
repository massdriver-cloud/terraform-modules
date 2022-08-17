locals {
  kube_distribution = var.kubernetes_cluster.specs.kubernetes.distribution
  opensearch = {
    image_version = "2.1.0"
    chart_version = "2.3.0"
    # add opensearch to the end of the release name, but don't stutter.
    release_name = trimsuffix(var.release, "opensearch") == var.release ? "${var.release}-opensearch" : var.release
  }
  helm_values = {
    rbac = {
      create             = true
      serviceAccountName = local.opensearch.release_name
    }
    image = {
      tag = local.opensearch.image_version
    }
    labels = var.md_metadata.default_tags
    // this lifecycle hook configure ISM (think retention) policies based on user input by making some calls to the opensearch API.
    // see: https://github.com/opensearch-project/helm-charts/blob/main/charts/opensearch/values.yaml#L373-L391
    lifecyle = length(var.ism_policies) > 0 ? {
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
                ${join("\n", [for k, v in var.ism_policies : "curl -XPUT \"$ES_URL/_template/${k}\" -H 'Content-Type: application/json' -d '${v}'"])}
                EOF
          ]
        }
      }
    } : {}
  }
  extraObjects = [
    templatefile("${path.module}/tls_secret.yml.tftpl", {
      name      = "${local.opensearch.release_name}-tls"
      namespace = var.namespace
      key = tls_private_key.opensearch_tls.private_key_pem
      cert = tls_self_signed_cert.opensearch_tls.cert_pem
    })
  ]
}

resource "tls_private_key" "opensearch" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_self_signed_cert" "opensearch" {
  private_key_pem = tls_private_key.opensearch.private_key_pem
  subject {
    common_name  = "massdriver.cloud"
    organization = "MassDriver Inc"
  }
  validity_period_hours = 24 * 365 * 5 # 5 years
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
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
    local.kube_distribution == "gke" ? "${file("${path.module}/gke_sysctl_values.yaml")}" : "${file("${path.module}/sysctl_values.yaml")}",
    yamlencode(local.helm_values),
    yamlencode(var.helm_additional_values),
  ]
}
