resource "google_project_service" "main" {
  for_each = toset(var.services)
  service  = each.value

  disable_dependent_services = false
  disable_on_destroy         = false
}

resource "null_resource" "waiter" {
  triggers = {
    sleep_time = var.seconds_to_sleep
    services   = join(",", var.services)
  }
  provisioner "local-exec" {
    command = "sleep ${var.seconds_to_sleep}"
  }

  depends_on = [google_project_service.main]
}
