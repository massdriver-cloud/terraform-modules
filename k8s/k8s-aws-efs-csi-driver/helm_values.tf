locals {
  helm_values = {
    controller = {
      serviceAccount = {
        create = true
        name   = local.controller_service_account_name
        annotations = {
          "eks.amazonaws.com/role-arn" : aws_iam_role.efs_csi_controller.arn
        }
      }
    }
    node = {
      serviceAccount = {
        create = true
        name   = local.node_service_account_name
      }
    }
    storageClasses = [for sc_name, efs_arn in var.storage_class_to_efs_arn_map : {
      name = sc_name
      mountOptions = ["tls"]
      parameters = {
        provisioningMode = "efs-ap"
        fileSystemId = split("/", efs_arn)[1]
        directoryPerms = "700"
      }
      reclaimPolicy = "Delete"
      volumeBindingMode = "Immediate"
    }]
  }
}
