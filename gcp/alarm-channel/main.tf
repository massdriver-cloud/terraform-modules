module "apis" {
  source   = "github.com/massdriver-cloud/terraform-modules//gcp-enable-apis?ref=c46bc59"
  services = ["monitoring.googleapis.com"]
}

resource "google_monitoring_notification_channel" "main" {
  display_name = var.name
  type         = "webhook_tokenauth"
  labels = {
    url = var.alarm_webhook_url
  }
  user_labels = {
    md-package = var.name
  }
  depends_on = [module.apis]
}
