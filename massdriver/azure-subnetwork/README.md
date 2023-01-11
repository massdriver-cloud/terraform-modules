# azure-subnetwork

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_massdriver"></a> [massdriver](#requirement\_massdriver) | ~> 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.38.0 |
| <a name="provider_massdriver"></a> [massdriver](#provider\_massdriver) | 1.1.4 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_auto_cidr"></a> [auto\_cidr](#module\_auto\_cidr) | ../../azure/auto-cidr | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_subnet.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [massdriver_artifact.subnetwork](https://registry.terraform.io/providers/massdriver-cloud/massdriver/latest/docs/resources/artifact) | resource |
| [azurerm_resource_group.virtual_network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr"></a> [cidr](#input\_cidr) | Welcome to the 'I leave my cidr null' club, swag is on the way! | `string` | `null` | no |
| <a name="input_enable_auto_cidr"></a> [enable\_auto\_cidr](#input\_enable\_auto\_cidr) | We'll automatically size your network for you, you get back to the fun stuff. | `bool` | `true` | no |
| <a name="input_md_metadata"></a> [md\_metadata](#input\_md\_metadata) | massdriver | <pre>object({<br>    name_prefix  = string<br>    default_tags = any<br>  })</pre> | n/a | yes |
| <a name="input_network_mask"></a> [network\_mask](#input\_network\_mask) | n/a | `string` | `20` | no |
| <a name="input_region"></a> [region](#input\_region) | With Massdriver, you don't have to worry about your Cloud: https://docs.massdriver.cloud/bundles/custom-widgets-and-fields#supported-cloud-locations-regions | `string` | n/a | yes |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
