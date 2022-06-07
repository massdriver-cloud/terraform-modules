locals {
  runtime_human_to_enum = {
    "Node.js 16"    = "nodejs16"
    "Node.js 14"    = "nodejs14"
    "Python 3.9"    = "python39"
    "Python 3.8"    = "python38"
    "Go 1.16"       = "go116"
    "Go 1.13"       = "go113"
    "Java 17"       = "java17"
    "Java 17"       = "java11"
    ".NET Core 3.1" = "dotnet3"
    "Ruby 3.0"      = "ruby30"
    "Ruby 2.7"      = "ruby27"
    "PHP 7.4"       = "php74"
  }
  runtime = lookup(local.runtime_human_to_enum, var.runtime)
}

output "runtime" {
  value = local.runtime
}
