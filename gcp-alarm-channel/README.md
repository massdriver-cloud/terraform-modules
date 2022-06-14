# GCP Alarm Channel for Massdriver

Create a Monitoring Notification Channel for receiving GCP Monitoring alerts from bundles.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.24.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apis"></a> [apis](#module\_apis) | github.com/massdriver-cloud/terraform-modules//google-enable-apis | 9201b9f |

## Resources

| Name | Type |
|------|------|
| [google_monitoring_notification_channel.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_notification_channel) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_md_metadata"></a> [md\_metadata](#input\_md\_metadata) | Massdriver package metadata object. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Alarm Channel Monitoring Notification Channel ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
