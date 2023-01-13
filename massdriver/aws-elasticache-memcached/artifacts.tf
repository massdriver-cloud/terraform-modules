locals {
  clustered_endpoint     = aws_elasticache_replication_group.main.configuration_endpoint_address
  non_clustered_endpoint = aws_elasticache_replication_group.main.primary_endpoint_address

  data_infrastructure = {
    arn = aws_elasticache_replication_group.main.arn
  }
  data_authentication = {
    hostname = var.cluster_mode_enabled ? local.clustered_endpoint : local.non_clustered_endpoint
    username = ""
    password = var.secure ? random_password.auth[0].result : ""
    port     = 6379
  }
  specs_cache = {
    "engine"  = "redis"
    "version" = aws_elasticache_replication_group.main.engine_version_actual
  }

  artifact_authentication = {
    data = {
      infrastructure = local.data_infrastructure
      authentication = local.data_authentication
      security       = {}
    }
    specs = {
      cache = local.specs_cache
    }
  }
}

resource "massdriver_artifact" "authentication" {
  field                = "authentication"
  provider_resource_id = aws_elasticache_replication_group.main.arn
  name                 = "${var.md_metadata.name_prefix}: Elasticache Redis"
  artifact             = jsonencode(local.artifact_authentication)
}
