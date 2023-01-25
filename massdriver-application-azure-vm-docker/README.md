<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.40.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |
| <a name="provider_utility"></a> [utility](#provider\_utility) | 0.0.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_application"></a> [application](#module\_application) | /Users/wbeebe/repos/massdriver-cloud/_azure-identity/terraform-modules/massdriver-application | n/a |
| <a name="module_public_endpoint"></a> [public\_endpoint](#module\_public\_endpoint) | github.com/massdriver-cloud/terraform-modules//azure/endpoint | 2cad7a7 |

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine_scale_set.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | resource |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [random_password.main](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [utility_available_cidr.cidr](https://registry.terraform.io/providers/massdriver-cloud/utility/latest/docs/resources/available_cidr) | resource |
| [azurerm_subnet.default](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.lookup](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.lookup](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_scaling_enabled"></a> [auto\_scaling\_enabled](#input\_auto\_scaling\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_container"></a> [container](#input\_container) | n/a | <pre>object({<br>    repository = string<br>    tag        = optional(string, "latest")<br>  })</pre> | n/a | yes |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | n/a | <pre>object({<br>    enabled   = bool<br>    zone_id   = optional(string, null)<br>    subdomain = optional(string, null)<br>  })</pre> | <pre>{<br>  "enabled": false<br>}</pre> | no |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | n/a | <pre>object({<br>    port = optional(number, 80)<br>    path = optional(string, "/")<br>  })</pre> | <pre>{<br>  "path": "/"<br>}</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_port"></a> [port](#input\_port) | n/a | `number` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | n/a | yes |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud_init_rendered"></a> [cloud\_init\_rendered](#output\_cloud\_init\_rendered) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

Might need to make a subnet just for this gateway.

```
│ Error: creating Application Gateway: (Name "local-beebe-vm-003" / Resource Group "local-beebe-vm-003"): network.ApplicationGatewaysClient#CreateOrUpdate: Failure sending request: StatusCode=400 -- Original Error: Code="ApplicationGatewaySubnetCannotHaveOtherResources" Message="Subnet /subscriptions/4718857a-5dbe-452c-a172-21a3ae74304f/resourceGroups/beebeaz-dev-west-hyst/providers/Microsoft.Network/virtualNetworks/beebeaz-dev-west-hyst/subnets/default cannot be used for application gateway /subscriptions/4718857a-5dbe-452c-a172-21a3ae74304f/resourceGroups/local-beebe-vm-003/providers/Microsoft.Network/applicationGateways/local-beebe-vm-003 since it has other resources deployed. Subnet used for application gateway can only have other application gateways." Details=[]
```


- https://techcommunity.microsoft.com/t5/azure-networking-blog/azure-application-gateway-502-error-due-to-backend-certificate/ba-p/3271805
