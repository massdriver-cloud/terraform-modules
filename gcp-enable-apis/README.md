# terraform-google-enable-apis

This module takes a list of Google Cloud APIs and then will wait a variable amount of time for the APIs to be live. API enablement in GCP is asynchronous. If a Terraform workspace enables an API then tries to use that resource, this will often produce an error because the API is not yet live.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.32.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_project_service.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [null_resource.waiter](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_seconds_to_sleep"></a> [seconds\_to\_sleep](#input\_seconds\_to\_sleep) | n/a | `number` | `30` | no |
| <a name="input_services"></a> [services](#input\_services) | n/a | `list(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
