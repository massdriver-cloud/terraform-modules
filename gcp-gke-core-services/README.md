# gcp-gke-core-services

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | ~> 4.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.0 |
| <a name="requirement_massdriver"></a> [massdriver](#requirement\_massdriver) | ~> 1.1 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.47.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.16.1 |
| <a name="provider_massdriver"></a> [massdriver](#provider\_massdriver) | 1.1.4 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cert_manager"></a> [cert\_manager](#module\_cert\_manager) | github.com/massdriver-cloud/terraform-modules//k8s-cert-manager-gcp | c336d59 |
| <a name="module_external_dns"></a> [external\_dns](#module\_external\_dns) | github.com/massdriver-cloud/terraform-modules//k8s-external-dns-gcp | 64b906f |
| <a name="module_fluentbit"></a> [fluentbit](#module\_fluentbit) | github.com/massdriver-cloud/terraform-modules//k8s-fluentbit | f920d78 |
| <a name="module_ingress_nginx"></a> [ingress\_nginx](#module\_ingress\_nginx) | github.com/massdriver-cloud/terraform-modules//k8s-ingress-nginx | c336d59 |
| <a name="module_kube-state-metrics"></a> [kube-state-metrics](#module\_kube-state-metrics) | github.com/massdriver-cloud/terraform-modules//k8s-kube-state-metrics | c336d59 |
| <a name="module_opensearch"></a> [opensearch](#module\_opensearch) | github.com/massdriver-cloud/terraform-modules//k8s-opensearch | 5fc9525 |

## Resources

| Name | Type |
|------|------|
| [kubernetes_cluster_role_binding.massdriver-cloud-provisioner](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_daemonset.nvidia_driver](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/daemonset) | resource |
| [kubernetes_service_account.massdriver-cloud-provisioner](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [massdriver_artifact.kubernetes_cluster](https://registry.terraform.io/providers/massdriver-cloud/massdriver/latest/docs/resources/artifact) | resource |
| [google_client_config.provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |
| [google_container_cluster.cluster](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/container_cluster) | data source |
| [google_dns_managed_zone.hosted_zones](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/dns_managed_zone) | data source |
| [kubernetes_secret.massdriver-cloud-provisioner_service-account_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_dns_managed_zones"></a> [cloud\_dns\_managed\_zones](#input\_cloud\_dns\_managed\_zones) | n/a | `any` | `[]` | no |
| <a name="input_enable_ingress"></a> [enable\_ingress](#input\_enable\_ingress) | n/a | `bool` | `false` | no |
| <a name="input_gcp_config"></a> [gcp\_config](#input\_gcp\_config) | n/a | <pre>object({<br>    project_id = string<br>    region     = string<br>  })</pre> | n/a | yes |
| <a name="input_logging"></a> [logging](#input\_logging) | n/a | <pre>object({<br>    opensearch = optional(object({<br>      enabled             = bool<br>      persistence_size_gi = optional(number, 10)<br>      retention_days      = optional(number, 7)<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_md_metadata"></a> [md\_metadata](#input\_md\_metadata) | n/a | `any` | n/a | yes |
| <a name="input_node_groups"></a> [node\_groups](#input\_node\_groups) | n/a | `any` | `[]` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
