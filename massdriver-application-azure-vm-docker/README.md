<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.40.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_application"></a> [application](#module\_application) | /Users/wbeebe/repos/massdriver-cloud/_azure-identity/terraform-modules/massdriver-application | n/a |
| <a name="module_public_endpoint"></a> [public\_endpoint](#module\_public\_endpoint) | ../../modules-managed-cert/azure/endpoint | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine_scale_set.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | resource |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [random_password.main](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azurerm_subnet.default](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_scaling_enabled"></a> [auto\_scaling\_enabled](#input\_auto\_scaling\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_azure_service_principal"></a> [azure\_service\_principal](#input\_azure\_service\_principal) | n/a | `any` | n/a | yes |
| <a name="input_container"></a> [container](#input\_container) | n/a | <pre>object({<br>    repository = string<br>    tag        = optional(string, "latest")<br>  })</pre> | n/a | yes |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | n/a | <pre>object({<br>    enabled   = bool<br>    zone_id   = optional(string, null)<br>    subdomain = optional(string, null)<br>  })</pre> | <pre>{<br>  "enabled": false<br>}</pre> | no |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | n/a | <pre>object({<br>    port = optional(number, 80)<br>    path = optional(string, "/")<br>  })</pre> | <pre>{<br>  "path": "/"<br>}</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | n/a | yes |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
