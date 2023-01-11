# auto-cidr

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.38.0 |
| <a name="provider_utility"></a> [utility](#provider\_utility) | 0.0.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [utility_available_cidr.main](https://registry.terraform.io/providers/massdriver-cloud/utility/latest/docs/resources/available_cidr) | resource |
| [azurerm_subnet.lookup](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.lookup](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_network_mask"></a> [network\_mask](#input\_network\_mask) | n/a | `number` | `22` | no |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cidr"></a> [cidr](#output\_cidr) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
