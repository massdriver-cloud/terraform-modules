# massdriver-application-helm

Helm implementation of [`massdriver-application`](../massdriver-application).

This module:
* configures an application's IAM for a specific service to run on Massdriver provisioned infrastructure in a cloud agnostic way
* deploys your helm chart in a cloud agnostic way

It creates an IAM Role or Service Account (depending on the cloud), gives permissions to the cloud services (lambda, ec2, k8s) to assume the role, and binds application level permissions from massdriver artifacts' security policies (SQS, S3, etc).

It also parses `policies` and `envs` from the _massdriver.yaml_ `app` field.

It provides a means to design applications in Massdriver to be cloud agnostic.

## Example

*Deploying a kubernetes workload*:

```hcl
module "helm" {
  source             = "github.com/massdriver-cloud/terraform-modules//massdriver-application-helm"
  name               = var.md_metadata.name_prefix
  namespace          = var.namespace
  chart              = "${path.module}/chart"
  kubernetes_cluster = var.kubernetes_cluster
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_application"></a> [application](#module\_application) | github.com/massdriver-cloud/terraform-modules//massdriver-application | 911db7e |
| <a name="module_massdriver_helm_values"></a> [massdriver\_helm\_values](#module\_massdriver\_helm\_values) | github.com/massdriver-cloud/terraform-modules//massdriver-helm-values | 4b8d47a |

## Resources

| Name | Type |
|------|------|
| [helm_release.application](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_envs"></a> [additional\_envs](#input\_additional\_envs) | Additional environment variables to set | <pre>list(<br>    object({<br>      name  = string<br>      value = string<br>    })<br>  )</pre> | `[]` | no |
| <a name="input_chart"></a> [chart](#input\_chart) | The path to your Helm chart | `string` | n/a | yes |
| <a name="input_helm_additional_values"></a> [helm\_additional\_values](#input\_helm\_additional\_values) | Additional helm values to set | `map(any)` | `{}` | no |
| <a name="input_kubernetes_cluster"></a> [kubernetes\_cluster](#input\_kubernetes\_cluster) | Massdriver Kubernetes Cluster Artifact | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure only, the location of the resource group. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The release name of the chart, this should be your var.md\_metadata.name\_prefix | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace to deploy chart into | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Azure only, the name of resource group to create the Managed Identity in. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application"></a> [application](#output\_application) | The massdriver-application specification. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
