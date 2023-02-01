# managed-certificate

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_acme"></a> [acme](#provider\_acme) | 2.12.0 |
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.33.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.40.0 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.9.1 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [acme_certificate.main](https://registry.terraform.io/providers/vancluever/acme/latest/docs/resources/certificate) | resource |
| [acme_registration.main](https://registry.terraform.io/providers/vancluever/acme/latest/docs/resources/registration) | resource |
| [azuread_application.external_dns](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_service_principal.external_dns](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azuread_service_principal_password.external_dns](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal_password) | resource |
| [azurerm_key_vault.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.service](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.terraform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_certificate.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_certificate) | resource |
| [azurerm_role_assignment.cert_manager](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [time_sleep.wait_240_seconds](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [tls_private_key.main](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acme_registration_email_address"></a> [acme\_registration\_email\_address](#input\_acme\_registration\_email\_address) | n/a | `string` | n/a | yes |
| <a name="input_dns_zone_resource_group_name"></a> [dns\_zone\_resource\_group\_name](#input\_dns\_zone\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_full_domain"></a> [full\_domain](#input\_full\_domain) | n/a | `string` | n/a | yes |
| <a name="input_gateway_identity_principal_id"></a> [gateway\_identity\_principal\_id](#input\_gateway\_identity\_principal\_id) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ssl_certificate_name"></a> [ssl\_certificate\_name](#output\_ssl\_certificate\_name) | n/a |
| <a name="output_ssl_certificate_secret_id"></a> [ssl\_certificate\_secret\_id](#output\_ssl\_certificate\_secret\_id) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


#### Refernce Material
- https://terraformguru.com/terraform-real-world-on-azure-cloud/31-Azure-Application-Gateway-SSL-SelfSigned-KeyVault/
- https://stackoverflow.com/questions/69193030/terraform-how-to-attach-ssl-certificate-stored-in-azure-keyvault-to-an-applica
- https://itnext.io/lets-encrypt-certs-with-terraform-f870def3ce6d
- https://docs.oracle.com/cd/E24191_01/common/tutorials/authz_cert_attributes.html
