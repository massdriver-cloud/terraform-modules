# gcp-auto-cidr

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.45.0 |
| <a name="provider_utility"></a> [utility](#provider\_utility) | 0.0.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [utility_available_cidr.main](https://registry.terraform.io/providers/massdriver-cloud/utility/latest/docs/resources/available_cidr) | resource |
| [google_compute_network.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network) | data source |
| [google_compute_subnetwork.lookup](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_subnetwork) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | n/a | `string` | `"gcp-dev-vpc-97t4"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cidr"></a> [cidr](#output\_cidr) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
