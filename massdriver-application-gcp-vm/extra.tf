# provider "mdxc" {
#   gcp = {
#     project     = var.gcp_authentication.data.project_id
#     credentials = jsonencode(var.gcp_authentication.data)
#   }
# }

# provider "google" {
#   project     = var.gcp_authentication.data.project_id
#   credentials = jsonencode(var.gcp_authentication.data)
# }

# provider "google-beta" {
#   project     = var.gcp_authentication.data.project_id
#   credentials = jsonencode(var.gcp_authentication.data)
# }

# variable "gcp_authentication" {
#   type = any
# }
