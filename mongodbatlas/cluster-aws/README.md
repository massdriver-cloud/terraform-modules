# cluster-aws

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.59.0 |
| <a name="provider_mongodbatlas"></a> [mongodbatlas](#provider\_mongodbatlas) | 1.8.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.9.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_all_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_vpc_endpoint.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [mongodbatlas_advanced_cluster.main](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/advanced_cluster) | resource |
| [mongodbatlas_database_user.admin](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/database_user) | resource |
| [mongodbatlas_privatelink_endpoint.main](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/privatelink_endpoint) | resource |
| [mongodbatlas_privatelink_endpoint_service.main](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/privatelink_endpoint_service) | resource |
| [mongodbatlas_project.main](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/project) | resource |
| [random_string.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [time_sleep.wait_30_seconds](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_disk_size_gb"></a> [disk\_size\_gb](#input\_disk\_size\_gb) | The size of the disk for data storage | `number` | `20` | no |
| <a name="input_electable_node_count"></a> [electable\_node\_count](#input\_electable\_node\_count) | The number of electable nodes | `number` | `3` | no |
| <a name="input_instance_size"></a> [instance\_size](#input\_instance\_size) | The instance size | `string` | `"M20"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to associate with mongodb atlas resources | `map(string)` | n/a | yes |
| <a name="input_max_instance_size"></a> [max\_instance\_size](#input\_max\_instance\_size) | The max instance size | `string` | `"M80"` | no |
| <a name="input_min_instance_size"></a> [min\_instance\_size](#input\_min\_instance\_size) | The min instance size | `string` | `"M10"` | no |
| <a name="input_mongodb_organization_id"></a> [mongodb\_organization\_id](#input\_mongodb\_organization\_id) | The MongoDB Atlas Organization ID | `string` | n/a | yes |
| <a name="input_mongodb_version"></a> [mongodb\_version](#input\_mongodb\_version) | The MongoDB version to use in the Cluser | `string` | `"4.4"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of project to create in MongoDB atlas | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS region to create the MongoDB Atlas cluster in | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | The subnet APIs where to create the private link to the MongoDB cluster | `set(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The AWS VPC to create the private link to the MongoDB cluster | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_connection_url"></a> [cluster\_connection\_url](#output\_cluster\_connection\_url) | n/a |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | n/a |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | n/a |
| <a name="output_cluster_srv_connection_url"></a> [cluster\_srv\_connection\_url](#output\_cluster\_srv\_connection\_url) | n/a |
| <a name="output_password"></a> [password](#output\_password) | n/a |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | n/a |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | n/a |
| <a name="output_username"></a> [username](#output\_username) | n/a |
| <a name="output_version"></a> [version](#output\_version) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
