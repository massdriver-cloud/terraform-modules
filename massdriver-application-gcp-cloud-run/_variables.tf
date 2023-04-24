variable "md_metadata" {
  type        = any
  description = "Massdriver metadata which is provided by the Massdriver deployment runtime"
}

variable "platform" {
  type = object({
    location      = string
    max_instances = number
  })
}

variable "container" {
  type = object({
    image = object({
      repository = string
      tag        = string
    })
    port        = number
    concurrency = number
  })
}

variable "endpoint" {
  type = any
}

variable "vpc_connector" {
  type = string
}
