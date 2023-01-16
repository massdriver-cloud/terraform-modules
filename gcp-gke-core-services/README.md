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
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.48.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.16.1 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.9.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cert_manager"></a> [cert\_manager](#module\_cert\_manager) | github.com/massdriver-cloud/terraform-modules//k8s-cert-manager-gcp | c336d59 |
| <a name="module_external_dns"></a> [external\_dns](#module\_external\_dns) | github.com/massdriver-cloud/terraform-modules//k8s-external-dns-gcp | 64b906f |
| <a name="module_ingress_nginx"></a> [ingress\_nginx](#module\_ingress\_nginx) | github.com/massdriver-cloud/terraform-modules//k8s-ingress-nginx | c336d59 |
| <a name="module_kube-state-metrics"></a> [kube-state-metrics](#module\_kube-state-metrics) | github.com/massdriver-cloud/terraform-modules//k8s-kube-state-metrics | c336d59 |

## Resources

| Name | Type |
|------|------|
| [kubernetes_cluster_role_binding_v1.massdriver-cloud-provisioner](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding_v1) | resource |
| [kubernetes_daemonset.nvidia_driver](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/daemonset) | resource |
| [kubernetes_namespace_v1.md-core-services](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1) | resource |
| [kubernetes_namespace_v1.md-observability](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1) | resource |
| [kubernetes_secret_v1.massdriver-cloud-provisioner_token](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret_v1) | resource |
| [kubernetes_service_account_v1.massdriver-cloud-provisioner](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account_v1) | resource |
| [time_sleep.wait_for_secret_token](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [google_client_config.provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |
| [google_container_cluster.cluster](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/container_cluster) | data source |
| [google_dns_managed_zone.hosted_zones](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/dns_managed_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_dns_managed_zones"></a> [cloud\_dns\_managed\_zones](#input\_cloud\_dns\_managed\_zones) | n/a | `any` | `[]` | no |
| <a name="input_enable_ingress"></a> [enable\_ingress](#input\_enable\_ingress) | n/a | `bool` | `false` | no |
| <a name="input_gcp_config"></a> [gcp\_config](#input\_gcp\_config) | n/a | <pre>object({<br>    project_id = string<br>    region     = string<br>  })</pre> | n/a | yes |
| <a name="input_kubernetes_cluster_artifact"></a> [kubernetes\_cluster\_artifact](#input\_kubernetes\_cluster\_artifact) | The Massdriver Kubernetes Cluster artifact. | `any` | n/a | yes |
| <a name="input_md_metadata"></a> [md\_metadata](#input\_md\_metadata) | n/a | `any` | n/a | yes |
| <a name="input_node_groups"></a> [node\_groups](#input\_node\_groups) | n/a | `any` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kubernetes_token"></a> [kubernetes\_token](#output\_kubernetes\_token) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
