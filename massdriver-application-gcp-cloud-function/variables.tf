variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "runtime" {
  type = string
}

variable "source_archive" {
  type = object({
    bucket = string
    object = string
  })
}

variable "cloud_function_configuration" {
  type = object({
    entrypoint        = string
    memory_mb         = number
    minimum_instances = number
    maximum_instances = number
  })
}

variable "endpoint" {
  type = any
}




