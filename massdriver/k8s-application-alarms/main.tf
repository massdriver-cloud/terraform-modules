// POD ALARMS
module "pod_crash_looping" {
  count                 = var.pod_alarms ? 1 : 0
  source                = "github.com/massdriver-cloud/terraform-modules//k8s/prometheus-alarm?ref=f8a6406"
  md_metadata           = var.md_metadata
  display_name          = "Pods Crash Looping"
  prometheus_alert_name = "KubePodCrashLooping"
}

module "pod_not_ready" {
  count                 = var.pod_alarms ? 1 : 0
  source                = "github.com/massdriver-cloud/terraform-modules//k8s/prometheus-alarm?ref=f8a6406"
  md_metadata           = var.md_metadata
  display_name          = "Pods Ready"
  prometheus_alert_name = "KubePodNotReady"
}


// DEPLOYMENT ALARMS
module "deployment_generation_mismatch" {
  count                 = var.deployment_alarms ? 1 : 0
  source                = "github.com/massdriver-cloud/terraform-modules//k8s/prometheus-alarm?ref=f8a6406"
  md_metadata           = var.md_metadata
  display_name          = "Deployment Rollout Successful"
  prometheus_alert_name = "KubeDeploymentGenerationMismatch"
}

// STATEFULSET ALARMS
module "statefulset_generation_mismatch" {
  count                 = var.statefulset_alarms ? 1 : 0
  source                = "github.com/massdriver-cloud/terraform-modules//k8s/prometheus-alarm?ref=f8a6406"
  md_metadata           = var.md_metadata
  display_name          = "StatefulSet Rollout Successful"
  prometheus_alert_name = "KubeStatefulSetGenerationMismatch"
}

// DAEMONSET ALARMS
module "daemonset_generation_mismatch" {
  count                 = var.daemonset_alarms ? 1 : 0
  source                = "github.com/massdriver-cloud/terraform-modules//k8s/prometheus-alarm?ref=f8a6406"
  md_metadata           = var.md_metadata
  display_name          = "DaemonSet Rollout Successful"
  prometheus_alert_name = "KubeDaemonSetRolloutStuck"
}

// JOB ALARMS
module "job_failed" {
  count                 = var.job_alarms ? 1 : 0
  source                = "github.com/massdriver-cloud/terraform-modules//k8s/prometheus-alarm?ref=f8a6406"
  md_metadata           = var.md_metadata
  display_name          = "Jobs Succeeded"
  prometheus_alert_name = "KubeJobFailed"
}

// HPA ALARMS
module "hpa_maxed_out" {
  count                 = var.hpa_alarms ? 1 : 0
  source                = "github.com/massdriver-cloud/terraform-modules//k8s/prometheus-alarm?ref=f8a6406"
  md_metadata           = var.md_metadata
  display_name          = "Horizontal Pod Autoscaler Headroom"
  prometheus_alert_name = "KubeHpaMaxedOut"
}
