# azure-monitor-metrics-alarm

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_massdriver"></a> [massdriver](#provider\_massdriver) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_metric_alert.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [massdriver_package_alarm.package_alarm](https://registry.terraform.io/providers/massdriver-cloud/massdriver/latest/docs/resources/package_alarm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aggregation"></a> [aggregation](#input\_aggregation) | The statistic that runs over the metric values. Possible values are Average, Count, Minimum, Maximum and Total. | `string` | n/a | yes |
| <a name="input_alarm_name"></a> [alarm\_name](#input\_alarm\_name) | The name of the Metric Alert. | `string` | n/a | yes |
| <a name="input_dimensions"></a> [dimensions](#input\_dimensions) | n/a | <pre>set(object({<br>    name     = string<br>    operator = string<br>    values   = list(string)<br>    })<br>  )</pre> | `[]` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | Short name to display in the massdriver UI. | `string` | n/a | yes |
| <a name="input_frequency"></a> [frequency](#input\_frequency) | The evaluation frequency of this Metric Alert, represented in ISO 8601 duration format. Possible values are PT1M, PT5M, PT15M, PT30M and PT1H. Defaults to PT1M. | `string` | n/a | yes |
| <a name="input_md_metadata"></a> [md\_metadata](#input\_md\_metadata) | Massdriver Variables | `any` | n/a | yes |
| <a name="input_message"></a> [message](#input\_message) | n/a | `string` | n/a | yes |
| <a name="input_metric_name"></a> [metric\_name](#input\_metric\_name) | One of the metric names to be monitored. | `string` | n/a | yes |
| <a name="input_metric_namespace"></a> [metric\_namespace](#input\_metric\_namespace) | One of the metric namespaces to be monitored. | `string` | n/a | yes |
| <a name="input_monitor_action_group_id"></a> [monitor\_action\_group\_id](#input\_monitor\_action\_group\_id) | Massdriver Alarm Channel - Action Group ID | `string` | n/a | yes |
| <a name="input_operator"></a> [operator](#input\_operator) | The criteria or dimension operator. Possible values are Equals, NotEquals, GreaterThan, GreaterThanOrEqual, LessThan and LessThanOrEqual. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource Group of the Monitor Action Group and Metric Rules. | `string` | n/a | yes |
| <a name="input_scopes"></a> [scopes](#input\_scopes) | A set of strings of resource IDs at which the metric criteria should be applied. | `set(string)` | n/a | yes |
| <a name="input_severity"></a> [severity](#input\_severity) | The severity of this Metric Alert. Possible values are 0, 1, 2, 3 and 4. Defaults to 3. | `string` | n/a | yes |
| <a name="input_threshold"></a> [threshold](#input\_threshold) | The criteria threshold value that activates the alert. | `string` | n/a | yes |
| <a name="input_window_size"></a> [window\_size](#input\_window\_size) | The period of time that is used to monitor alert activity, represented in ISO 8601 duration format. This value must be greater than frequency. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
