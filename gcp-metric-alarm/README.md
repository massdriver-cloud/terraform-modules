# gcp-metric-alarm

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_massdriver"></a> [massdriver](#provider\_massdriver) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_monitoring_alert_policy.bool](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_alert_policy) | resource |
| [google_monitoring_alert_policy.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_alert_policy) | resource |
| [massdriver_package_alarm.package_alarm](https://registry.terraform.io/providers/massdriver-cloud/massdriver/latest/docs/resources/package_alarm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_configuration"></a> [alarm\_configuration](#input\_alarm\_configuration) | n/a | <pre>object({<br>    metric_type        = string<br>    resource_type      = string<br>    threshold          = number<br>    duration_s         = optional(number, 60)<br>    alignment_period_s = optional(number, 60)<br>    value_type         = optional(string, "DOUBLE")<br>  })</pre> | n/a | yes |
| <a name="input_cloud_resource_id"></a> [cloud\_resource\_id](#input\_cloud\_resource\_id) | The identifier for what resource is producing the metrics. Usually it's the self\_link attribute of the resource. | `string` | n/a | yes |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | Short name to display in the massdriver UI. | `string` | n/a | yes |
| <a name="input_md_metadata"></a> [md\_metadata](#input\_md\_metadata) | Massdriver metadata | `any` | n/a | yes |
| <a name="input_message"></a> [message](#input\_message) | A message including additional context for this alarm. | `string` | n/a | yes |
| <a name="input_notification_channel_id"></a> [notification\_channel\_id](#input\_notification\_channel\_id) | Massdriver Alarm Channel - Notification Channel ID | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
