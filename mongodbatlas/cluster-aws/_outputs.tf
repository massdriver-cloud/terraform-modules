output "project_id" {
  value = mongodbatlas_project.main.id
}

output "cluster_id" {
  value = mongodbatlas_advanced_cluster.main.cluster_id
}

output "cluster_name" {
  value = mongodbatlas_advanced_cluster.main.name
}

output "cluster_connection_url" {
  value = mongodbatlas_advanced_cluster.main.connection_strings[0].private_endpoint[0].connection_string
}

output "cluster_srv_connection_url" {
  value = mongodbatlas_advanced_cluster.main.connection_strings[0].private_endpoint[0].srv_connection_string
}

output "username" {
  value = mongodbatlas_database_user.admin.username
}

output "password" {
  value     = mongodbatlas_database_user.admin.password
  sensitive = true
}

output "security_group_id" {
  value = aws_security_group.main.0.id
}

output "version" {
  value = mongodbatlas_advanced_cluster.main.mongo_db_version
}
