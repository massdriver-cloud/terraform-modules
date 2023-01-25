# endpoint

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.40.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_managed_certificate"></a> [managed\_certificate](#module\_managed\_certificate) | github.com/massdriver-cloud/terraform-modules//azure/managed-certificate | bf36471 |

## Resources

| Name | Type |
|------|------|
| [azurerm_application_gateway.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway) | resource |
| [azurerm_dns_a_record.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_cname_record.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_cname_record) | resource |
| [azurerm_public_ip.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_user_assigned_identity.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_dns_zone.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_zone) | data source |
| [azurerm_public_ip.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/public_ip) | data source |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dns_zone_name"></a> [dns\_zone\_name](#input\_dns\_zone\_name) | n/a | `string` | n/a | yes |
| <a name="input_dns_zone_resource_group_name"></a> [dns\_zone\_resource\_group\_name](#input\_dns\_zone\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | n/a | <pre>object({<br>    path = optional(string, "/")<br>    port = optional(number, 80)<br>  })</pre> | <pre>{<br>  "path": "/",<br>  "port": 80<br>}</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_port"></a> [port](#input\_port) | n/a | `number` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | n/a | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backend_address_pool"></a> [backend\_address\_pool](#output\_backend\_address\_pool) | n/a |
| <a name="output_load_balancer_backend_address_pool_ids"></a> [load\_balancer\_backend\_address\_pool\_ids](#output\_load\_balancer\_backend\_address\_pool\_ids) | https://github.com/hashicorp/terraform-provider-azurerm/issues/16855 this can be 1-many regional load balancers |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

#### Refernce Material
- https://learn.microsoft.com/en-us/azure/application-gateway/overview-v2
- https://learn.microsoft.com/en-us/azure/application-gateway/ssl-overview
- https://learn.microsoft.com/en-us/azure/application-gateway/key-vault-certs
- https://learn.microsoft.com/en-us/azure/application-gateway/url-route-overview
- https://learn.microsoft.com/en-us/azure/developer/terraform/deploy-application-gateway-v2#2-implement-the-terraform-code
- https://terraformguru.com/terraform-real-world-on-azure-cloud/31-Azure-Application-Gateway-SSL-SelfSigned-KeyVault/
- https://learn.microsoft.com/en-us/azure/web-application-firewall/ag/ag-overview
