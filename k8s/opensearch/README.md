# k8s-opensearch

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.dashboards](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.opensearch](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dashboards_helm_additional_values"></a> [dashboards\_helm\_additional\_values](#input\_dashboards\_helm\_additional\_values) | Map of additional values to configure in opensearch-dashboards helm chart | `map` | `{}` | no |
| <a name="input_enable_dashboards"></a> [enable\_dashboards](#input\_enable\_dashboards) | This will additionally deploy the opensearch-dashboards helm chart | `bool` | `false` | no |
| <a name="input_helm_additional_values"></a> [helm\_additional\_values](#input\_helm\_additional\_values) | Map of additional values to configure in opensearch helm chart | `map` | `{}` | no |
| <a name="input_ism_policies"></a> [ism\_policies](#input\_ism\_policies) | Map of ISM policies to configure in the opensearch cluster. keys should be template names and bodies should be the ISM policy body | `map` | `{}` | no |
| <a name="input_kubernetes_cluster"></a> [kubernetes\_cluster](#input\_kubernetes\_cluster) | A kubernetes\_cluster artifact | `any` | n/a | yes |
| <a name="input_md_metadata"></a> [md\_metadata](#input\_md\_metadata) | md\_metadata object | `any` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace | `string` | n/a | yes |
| <a name="input_release"></a> [release](#input\_release) | Release name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dashboards_url"></a> [dashboards\_url](#output\_dashboards\_url) | n/a |
| <a name="output_service_url"></a> [service\_url](#output\_service\_url) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
