# k8s-aws-efs-csi-driver

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.16.2 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.11.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.efs_csi_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [helm_release.main](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [aws_arn.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/arn) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eks_cluster_arn"></a> [eks\_cluster\_arn](#input\_eks\_cluster\_arn) | A kubernetes\_cluster artifact | `string` | n/a | yes |
| <a name="input_eks_oidc_issuer_url"></a> [eks\_oidc\_issuer\_url](#input\_eks\_oidc\_issuer\_url) | A kubernetes\_cluster artifact | `string` | n/a | yes |
| <a name="input_helm_additional_values"></a> [helm\_additional\_values](#input\_helm\_additional\_values) | Map of additional values to configure in helm chart | `any` | `{}` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | name prefix to apply to resources object | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace | `string` | n/a | yes |
| <a name="input_release"></a> [release](#input\_release) | Release name | `string` | n/a | yes |
| <a name="input_storage_class_to_efs_arn_map"></a> [storage\_class\_to\_efs\_arn\_map](#input\_storage\_class\_to\_efs\_arn\_map) | Map of storage class names to EFS volume ARNs | `map` | `{}` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
