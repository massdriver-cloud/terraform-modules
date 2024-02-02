# k8s-external-dns

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.12.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.external-dns](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dns_provider"></a> [dns\_provider](#input\_dns\_provider) | the name of the DNS provider, supported values are [aws, google] | `string` | n/a | yes |
| <a name="input_domain_filter_list"></a> [domain\_filter\_list](#input\_domain\_filter\_list) | a list of domains to allow | `list(string)` | `[]` | no |
| <a name="input_domain_filters"></a> [domain\_filters](#input\_domain\_filters) | DEPRECATED: a comman-separated list of domains to allow | `string` | n/a | yes |
| <a name="input_helm_additional_values"></a> [helm\_additional\_values](#input\_helm\_additional\_values) | a map of helm variables (key) to their values, used for setting anything in values.yaml | `any` | `{}` | no |
| <a name="input_kubernetes_cluster"></a> [kubernetes\_cluster](#input\_kubernetes\_cluster) | A kubernetes\_cluster artifact | `any` | n/a | yes |
| <a name="input_md_metadata"></a> [md\_metadata](#input\_md\_metadata) | md\_metadata object | `any` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace | `string` | n/a | yes |
| <a name="input_release"></a> [release](#input\_release) | Release name | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
