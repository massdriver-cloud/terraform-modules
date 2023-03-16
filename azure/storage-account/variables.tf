variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "kind" {
  type = string

  validation {
    condition     = contains(["BlobStorage", "StorageV2", "FileStorage", "BlockBlobStorage"], var.kind)
    error_message = "Valid values for kind are BlobStorage, StorageV2, FileStorage, BlockBlobStorage."
  }
}

variable "tier" {
  type = string

  validation {
    condition     = contains(["Standard", "Premium"], var.tier)
    error_message = "Valid values for tier are Standard or Premium."
  }
}

variable "replication_type" {
  type = string

  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.replication_type)
    error_message = "Valid values for replication_type are LRS, GRS, RAGRS, ZRS, GZRS, and RAGZRS."
  }
}

variable "access_tier" {
  type = string

  validation {
    condition     = contains(["Hot", "Cool"], var.access_tier)
    error_message = "Valid values for access_tier are Hot or Cool."
  }
}

variable "enable_data_lake" {
  type    = bool
  default = false
}

variable "tags" {
  type = any
}
