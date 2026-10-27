# prometheus-alarm

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_massdriver"></a> [massdriver](#requirement\_massdriver) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_massdriver"></a> [massdriver](#provider\_massdriver) | 2.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [massdriver_instance_alarm.main](https://registry.terraform.io/providers/massdriver-cloud/massdriver/latest/docs/resources/instance_alarm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | Short name to display in the massdriver UI. | `string` | n/a | yes |
| <a name="input_md_metadata"></a> [md\_metadata](#input\_md\_metadata) | The `md_metadata` block from Massdriver | `any` | n/a | yes |
| <a name="input_prometheus_alert_name"></a> [prometheus\_alert\_name](#input\_prometheus\_alert\_name) | The name of the prometheus alert this alarm is associated with | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
