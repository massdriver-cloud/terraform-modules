locals {
  connections = try(jsondecode(file("/massdriver/connections.json")), {})
  params      = try(jsondecode(file("/massdriver/params.json")), {})
  secrets     = try(jsondecode(file("/massdriver/secrets.json")), {})
  envs        = try(jsondecode(file("/massdriver/envs.json")), {})
  config      = try(yamldecode(file("/massdriver/config.json")), {})
}
