<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.42.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_cognitive_account.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_account) | resource |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_user_assigned_identity.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_subdomain_name"></a> [custom\_subdomain\_name](#input\_custom\_subdomain\_name) | The custom subdomain name. | `string` | n/a | yes |
| <a name="input_kind"></a> [kind](#input\_kind) | The Cognitive service to deploy. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location of the resource. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the resource. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU of the Cognitive service. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags of the resource. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_identity_id"></a> [identity\_id](#output\_identity\_id) | n/a |
| <a name="output_identity_principal_id"></a> [identity\_principal\_id](#output\_identity\_principal\_id) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
