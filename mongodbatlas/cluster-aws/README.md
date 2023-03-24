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
| [mongodbatlas_cloud_backup_schedule.main](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/cloud_backup_schedule) | resource |
| [mongodbatlas_database_user.admin](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/database_user) | resource |
| [mongodbatlas_privatelink_endpoint.main](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/privatelink_endpoint) | resource |
| [mongodbatlas_privatelink_endpoint_service.main](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/privatelink_endpoint_service) | resource |
| [mongodbatlas_project.main](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/project) | resource |
| [random_string.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [time_sleep.wait_30_seconds](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup_enabled"></a> [backup\_enabled](#input\_backup\_enabled) | Whether to enable cloud backups | `bool` | `true` | no |
| <a name="input_backup_schedule"></a> [backup\_schedule](#input\_backup\_schedule) | List of backup schedule policies | <pre>list(<br>    object({<br>      frequency_type     = string<br>      frequency_interval = number<br>      retention_unit     = string<br>      retention_value    = number<br>  }))</pre> | <pre>[<br>  {<br>    "frequency_interval": 1,<br>    "frequency_type": "daily",<br>    "retention_unit": "weeks",<br>    "retention_value": 4<br>  }<br>]</pre> | no |
| <a name="input_cluster_type"></a> [cluster\_type](#input\_cluster\_type) | The type of cluster you want to create. | `string` | `"REPLICASET"` | no |
| <a name="input_disk_iops"></a> [disk\_iops](#input\_disk\_iops) | The provisioned IOPS if the EBS type is "PROVISIONED" | `number` | `null` | no |
| <a name="input_disk_size_gb"></a> [disk\_size\_gb](#input\_disk\_size\_gb) | The size of the disk for data storage | `number` | `20` | no |
| <a name="input_ebs_volume_type"></a> [ebs\_volume\_type](#input\_ebs\_volume\_type) | The the type of EBS volume to use for storage | `string` | `"STANDARD"` | no |
| <a name="input_electable_node_count"></a> [electable\_node\_count](#input\_electable\_node\_count) | The number of electable nodes | `number` | `3` | no |
| <a name="input_instance_size"></a> [instance\_size](#input\_instance\_size) | The instance size | `string` | `"M10"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to associate with mongodb atlas resources | `map(string)` | n/a | yes |
| <a name="input_max_instance_size"></a> [max\_instance\_size](#input\_max\_instance\_size) | The max instance size | `string` | `"M80"` | no |
| <a name="input_min_instance_size"></a> [min\_instance\_size](#input\_min\_instance\_size) | The min instance size | `string` | `"M10"` | no |
| <a name="input_mongodb_organization_id"></a> [mongodb\_organization\_id](#input\_mongodb\_organization\_id) | The MongoDB Atlas Organization ID | `string` | n/a | yes |
| <a name="input_mongodb_version"></a> [mongodb\_version](#input\_mongodb\_version) | The MongoDB version to use in the Cluser | `string` | `"4.4"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of project to create in MongoDB atlas | `string` | n/a | yes |
| <a name="input_num_shards"></a> [num\_shards](#input\_num\_shards) | The number of shards to use in the database | `number` | `1` | no |
| <a name="input_pit_enabled"></a> [pit\_enabled](#input\_pit\_enabled) | Whether to enable continuous cloud backups (in addition to snapshot backups) | `bool` | `true` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region to create the MongoDB Atlas cluster in | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | The subnet APIs where to create the private link to the MongoDB cluster | `set(string)` | n/a | yes |
| <a name="input_termination_protection_enabled"></a> [termination\_protection\_enabled](#input\_termination\_protection\_enabled) | Whether to enable termination protection on the cluster | `bool` | `false` | no |
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
