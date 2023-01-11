# azure-virtual-network

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.0 |
| <a name="requirement_jq"></a> [jq](#requirement\_jq) | ~> 0.0 |
| <a name="requirement_massdriver"></a> [massdriver](#requirement\_massdriver) | ~> 1.0 |
| <a name="requirement_utility"></a> [utility](#requirement\_utility) | ~> 0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.38.0 |
| <a name="provider_http"></a> [http](#provider\_http) | 3.2.1 |
| <a name="provider_jq"></a> [jq](#provider\_jq) | 0.2.1 |
| <a name="provider_massdriver"></a> [massdriver](#provider\_massdriver) | 1.1.4 |
| <a name="provider_utility"></a> [utility](#provider\_utility) | 0.0.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [massdriver_artifact.virtual_network](https://registry.terraform.io/providers/massdriver-cloud/massdriver/latest/docs/resources/artifact) | resource |
| [utility_available_cidr.cidr](https://registry.terraform.io/providers/massdriver-cloud/utility/latest/docs/resources/available_cidr) | resource |
| [http_http.token](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.vnets](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [jq_query.vnet_cidrs](https://registry.terraform.io/providers/massdriver-cloud/jq/latest/docs/data-sources/query) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_authentication"></a> [authentication](#input\_authentication) | n/a | <pre>object({<br>    client_id       = string<br>    client_secret   = string<br>    tenant_id       = string<br>    subscription_id = string<br>  })</pre> | n/a | yes |
| <a name="input_cidr"></a> [cidr](#input\_cidr) | Welcome to the 'I leave my cidr null' club, swag is on the way! | `string` | `null` | no |
| <a name="input_enable_auto_cidr"></a> [enable\_auto\_cidr](#input\_enable\_auto\_cidr) | We'll automatically size your network for you, you get back to the fun stuff. | `bool` | `true` | no |
| <a name="input_md_metadata"></a> [md\_metadata](#input\_md\_metadata) | TODO: how do we generate these for the modules what "mass xyz" command could we add that could generate these from rich-types I'm thinking more and more of the CLI like a tiny GraphQL API itself Think of something, and jam it in there. | <pre>object({<br>    name_prefix  = string<br>    default_tags = any<br>  })</pre> | n/a | yes |
| <a name="input_network_mask"></a> [network\_mask](#input\_network\_mask) | n/a | `string` | `20` | no |
| <a name="input_region"></a> [region](#input\_region) | With Massdriver, you don't have to worry about your Cloud: https://docs.massdriver.cloud/bundles/custom-widgets-and-fields#supported-cloud-locations-regions | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
