# massdriver-package-alarm

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_massdriver"></a> [massdriver](#provider\_massdriver) | 1.1.5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [massdriver_package_alarm.main](https://registry.terraform.io/providers/massdriver-cloud/massdriver/latest/docs/resources/package_alarm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_resource_id"></a> [cloud\_resource\_id](#input\_cloud\_resource\_id) | The cloud resource ID. | `string` | n/a | yes |
| <a name="input_dimensions"></a> [dimensions](#input\_dimensions) | Dimensions map for the metric. | `any` | n/a | yes |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name of the alarm. | `string` | n/a | yes |
| <a name="input_metric_name"></a> [metric\_name](#input\_metric\_name) | The name of the metric. | `string` | n/a | yes |
| <a name="input_metric_namespace"></a> [metric\_namespace](#input\_metric\_namespace) | The namespace of the metric. | `string` | n/a | yes |
| <a name="input_statistic"></a> [statistic](#input\_statistic) | The statistic of the metric. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
