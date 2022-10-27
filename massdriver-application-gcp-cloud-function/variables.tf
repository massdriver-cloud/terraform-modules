variable "md_metadata" {
  type        = any
  description = "Massdriver metadata which is provided by the Massdriver deployment runtime"
}

variable "location" {
  type = string
}

variable "source_archive_path" {
  type    = string
  default = "placeholder-app.zip"
}

variable "cloud_function_configuration" {
  type = object({
    runtime           = string
    entrypoint        = string
    memory_mb         = number
    minimum_instances = number
    maximum_instances = number
  })
}

variable "endpoint" {
  type = any
}

variable "vpc_connector" {
  type = string
}
