# kube-prometheus-stack

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.10.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.kube_prometheus_stack](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.prometheus_rules](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kube_prometheus_stack_values"></a> [kube\_prometheus\_stack\_values](#input\_kube\_prometheus\_stack\_values) | Map of additional values to configure the kube-prometheus-stack helm chart | `any` | n/a | yes |
| <a name="input_md_metadata"></a> [md\_metadata](#input\_md\_metadata) | Massdriver md\_metadata object | `any` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace | `string` | n/a | yes |
| <a name="input_prometheus_rules_values"></a> [prometheus\_rules\_values](#input\_prometheus\_rules\_values) | Map of additional values to configure the prometheus-rules helm chart | `any` | n/a | yes |
| <a name="input_release"></a> [release](#input\_release) | Release name | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
