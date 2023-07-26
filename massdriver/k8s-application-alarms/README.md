# k8s-application-alarms

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_daemonset_generation_mismatch"></a> [daemonset\_generation\_mismatch](#module\_daemonset\_generation\_mismatch) | github.com/massdriver-cloud/terraform-modules//k8s/prometheus-alarm | 2ba8cd9b49c081c78f659f8c19b9026d73468abf |
| <a name="module_deployment_generation_mismatch"></a> [deployment\_generation\_mismatch](#module\_deployment\_generation\_mismatch) | github.com/massdriver-cloud/terraform-modules//k8s/prometheus-alarm | 2ba8cd9b49c081c78f659f8c19b9026d73468abf |
| <a name="module_hpa_maxed_out"></a> [hpa\_maxed\_out](#module\_hpa\_maxed\_out) | github.com/massdriver-cloud/terraform-modules//k8s/prometheus-alarm | 2ba8cd9b49c081c78f659f8c19b9026d73468abf |
| <a name="module_job_failed"></a> [job\_failed](#module\_job\_failed) | github.com/massdriver-cloud/terraform-modules//k8s/prometheus-alarm | 2ba8cd9b49c081c78f659f8c19b9026d73468abf |
| <a name="module_pod_crash_looping"></a> [pod\_crash\_looping](#module\_pod\_crash\_looping) | github.com/massdriver-cloud/terraform-modules//k8s/prometheus-alarm | 2ba8cd9b49c081c78f659f8c19b9026d73468abf |
| <a name="module_pod_not_ready"></a> [pod\_not\_ready](#module\_pod\_not\_ready) | github.com/massdriver-cloud/terraform-modules//k8s/prometheus-alarm | 2ba8cd9b49c081c78f659f8c19b9026d73468abf |
| <a name="module_statefulset_generation_mismatch"></a> [statefulset\_generation\_mismatch](#module\_statefulset\_generation\_mismatch) | github.com/massdriver-cloud/terraform-modules//k8s/prometheus-alarm | 2ba8cd9b49c081c78f659f8c19b9026d73468abf |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_daemonset_alarms"></a> [daemonset\_alarms](#input\_daemonset\_alarms) | Install daemonset alarms | `bool` | `false` | no |
| <a name="input_deployment_alarms"></a> [deployment\_alarms](#input\_deployment\_alarms) | Install deployment alarms | `bool` | `false` | no |
| <a name="input_hpa_alarms"></a> [hpa\_alarms](#input\_hpa\_alarms) | Install HPA alarms | `bool` | `false` | no |
| <a name="input_job_alarms"></a> [job\_alarms](#input\_job\_alarms) | Install job alarms | `bool` | `false` | no |
| <a name="input_md_metadata"></a> [md\_metadata](#input\_md\_metadata) | Massdriver md\_metadata object | `any` | n/a | yes |
| <a name="input_pod_alarms"></a> [pod\_alarms](#input\_pod\_alarms) | Install pod alarms | `bool` | `true` | no |
| <a name="input_statefulset_alarms"></a> [statefulset\_alarms](#input\_statefulset\_alarms) | Install statefulset alarms | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
