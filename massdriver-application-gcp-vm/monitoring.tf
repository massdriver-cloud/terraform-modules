locals {
  threshold_cpu = 0.9
  metrics = {
    "cpu" = {
      # metric for each instance or the whole group?
      metric   = "compute.googleapis.com/instance/cpu/utilization"
      resource = "gce_instance"
    }
  }
}

module "alarm_channel" {
  source      = "github.com/massdriver-cloud/terraform-modules//gcp-alarm-channel?ref=bfcf556"
  md_metadata = var.md_metadata
}

module "cpu_alarm" {
  source                  = "github.com/massdriver-cloud/terraform-modules//gcp-monitoring-utilization-threshold?ref=cafdc89"
  notification_channel_id = module.alarm_channel.id
  md_metadata             = var.md_metadata
  display_name            = "CPU Usage High"
  message                 = "CPU usage over threshold ${local.threshold_cpu * 100}%"
  alarm_name              = "highMemory"
  metric_type             = local.metrics["cpu"].metric
  resource_type           = local.metrics["cpu"].resource
  threshold               = local.threshold_cpu
  period                  = 60
  duration                = 60

  depends_on = [
    google_compute_instance_group_manager.main
  ]
}
