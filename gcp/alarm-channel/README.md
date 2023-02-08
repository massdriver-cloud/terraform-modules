# GCP Alarm Channel for Massdriver

Create a Monitoring Notification Channel for receiving GCP Monitoring alerts from bundles.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.52.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apis"></a> [apis](#module\_apis) | github.com/massdriver-cloud/terraform-modules//gcp-enable-apis | c46bc59 |

## Resources

| Name | Type |
|------|------|
| [google_monitoring_notification_channel.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_notification_channel) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_webhook_url"></a> [alarm\_webhook\_url](#input\_alarm\_webhook\_url) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Alarm Channel Monitoring Notification Channel ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
