
locals {
  mongo_region = upper(replace(var.region, "-", "_"))
}

resource "mongodbatlas_project" "main" {
  name   = var.name
  org_id = var.mongodb_organization_id
}

resource "mongodbatlas_advanced_cluster" "main" {
  depends_on = [
    mongodbatlas_privatelink_endpoint_service.main
  ]

  project_id             = mongodbatlas_project.main.id
  name                   = var.name
  mongo_db_major_version = var.mongodb_version
  cluster_type           = "REPLICASET"

  replication_specs {
    num_shards = 1
    region_configs {
      auto_scaling {
        disk_gb_enabled            = true
        compute_enabled            = true
        compute_scale_down_enabled = true
        compute_min_instance_size  = var.min_instance_size
        compute_max_instance_size  = var.max_instance_size
      }
      electable_specs {
        ebs_volume_type = "STANDARD"
        instance_size   = var.instance_size
        node_count      = var.electable_node_count
      }
      provider_name = "AWS"
      region_name   = local.mongo_region
      priority      = 7
    }
  }

  pit_enabled    = true
  backup_enabled = true
  disk_size_gb   = var.disk_size_gb

  dynamic "labels" {
    for_each = var.labels
    content {
      key   = labels.key
      value = labels.value
    }
  }

  # See: https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/cluster#auto_scaling_compute_enabled
  lifecycle {
    ignore_changes = [
      disk_size_gb,
      replication_specs[0].region_configs[0].electable_specs[0].instance_size
    ]
  }
}

resource "random_string" "password" {
  length  = 16
  special = false
}

resource "mongodbatlas_database_user" "admin" {
  username           = "${var.name}-admin"
  password           = random_string.password.result
  project_id         = mongodbatlas_project.main.id
  auth_database_name = "admin"

  roles {
    role_name     = "dbAdmin"
    database_name = mongodbatlas_advanced_cluster.main.name
  }

  dynamic "labels" {
    for_each = var.labels
    content {
      key   = labels.key
      value = labels.value
    }
  }

  scopes {
    name = mongodbatlas_advanced_cluster.main.name
    type = "CLUSTER"
  }
}
