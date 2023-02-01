<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_mdxc"></a> [mdxc](#requirement\_mdxc) | >= 0.10.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alarm_channel"></a> [alarm\_channel](#module\_alarm\_channel) | github.com/massdriver-cloud/terraform-modules//azure-alarm-channel | 40d6e54 |
| <a name="module_application"></a> [application](#module\_application) | github.com/massdriver-cloud/terraform-modules//massdriver-application | fc5f7b1 |
| <a name="module_auto_cidr"></a> [auto\_cidr](#module\_auto\_cidr) | github.com/massdriver-cloud/terraform-modules//azure/auto-cidr | 93bc06c |
| <a name="module_dns"></a> [dns](#module\_dns) | github.com/massdriver-cloud/terraform-modules//azure/dns | 9df7459 |
| <a name="module_http_4xx_metric_alert"></a> [http\_4xx\_metric\_alert](#module\_http\_4xx\_metric\_alert) | github.com/massdriver-cloud/terraform-modules//azure-monitor-metrics-alarm | 40d6e54 |
| <a name="module_http_5xx_metric_alert"></a> [http\_5xx\_metric\_alert](#module\_http\_5xx\_metric\_alert) | github.com/massdriver-cloud/terraform-modules//azure-monitor-metrics-alarm | 40d6e54 |
| <a name="module_response_metric_alert"></a> [response\_metric\_alert](#module\_response\_metric\_alert) | github.com/massdriver-cloud/terraform-modules//azure-monitor-metrics-alarm | 40d6e54 |

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_web_app.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app) | resource |
| [azurerm_monitor_autoscale_setting.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_service_plan.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |
| [azurerm_subnet.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_user_assigned_identity.container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_client_config.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application"></a> [application](#input\_application) | n/a | <pre>object({<br>    sku_name             = string<br>    minimum_worker_count = number<br>    maximum_worker_count = number<br>    zone_balancing       = bool<br>  })</pre> | n/a | yes |
| <a name="input_command"></a> [command](#input\_command) | n/a | `string` | `null` | no |
| <a name="input_contact_email"></a> [contact\_email](#input\_contact\_email) | n/a | `string` | n/a | yes |
| <a name="input_dns"></a> [dns](#input\_dns) | DNS configuration. | `any` | n/a | yes |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | n/a | <pre>object({<br>    port = optional(number, 80)<br>    path = optional(string, "/")<br>  })</pre> | n/a | yes |
| <a name="input_image"></a> [image](#input\_image) | n/a | <pre>object({<br>    repository = string<br>    tag        = string<br>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_md_metadata"></a> [md\_metadata](#input\_md\_metadata) | n/a | `any` | n/a | yes |
| <a name="input_monitoring"></a> [monitoring](#input\_monitoring) | n/a | <pre>object({<br>    mode = string<br>  })</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | n/a | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | n/a | yes |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Cloud ID for application IAM (AWS Role, GCP Service Account, Azure Managed Identity ID, etc) |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
