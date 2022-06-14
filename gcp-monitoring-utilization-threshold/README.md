# terraform-google-monitoring-utilization-threshold<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.24.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_monitoring_alert_policy.alert_policy](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_alert_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_name"></a> [alarm\_name](#input\_alarm\_name) | n/a | `string` | n/a | yes |
| <a name="input_duration"></a> [duration](#input\_duration) | n/a | `string` | n/a | yes |
| <a name="input_md_metadata"></a> [md\_metadata](#input\_md\_metadata) | Massdriver Variables | `any` | n/a | yes |
| <a name="input_message"></a> [message](#input\_message) | n/a | `string` | n/a | yes |
| <a name="input_metric_type"></a> [metric\_type](#input\_metric\_type) | n/a | `string` | n/a | yes |
| <a name="input_notification_channel_id"></a> [notification\_channel\_id](#input\_notification\_channel\_id) | Massdriver Alarm Channel - Notification Channel ID | `string` | n/a | yes |
| <a name="input_period"></a> [period](#input\_period) | n/a | `string` | n/a | yes |
| <a name="input_resource_type"></a> [resource\_type](#input\_resource\_type) | n/a | `string` | n/a | yes |
| <a name="input_threshold"></a> [threshold](#input\_threshold) | n/a | `number` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
