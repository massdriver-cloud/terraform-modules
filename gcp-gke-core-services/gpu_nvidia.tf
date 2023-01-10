locals {
  machine_types = join("", var.node_groups[*].machine_type)
  # https://cloud.google.com/compute/docs/gpus#a100-gpus
  install_nvidia_driver = length(regexall("-highgpu-|-megagpu-|-ultragpu-", local.machine_types)) > 0
}

# These drivers are required for the above machine types.
# In the UI, it doesn't allow you to _not_ install them when selecting these machine types.
# So, we install it for you.
# https://cloud.google.com/kubernetes-engine/docs/how-to/gpus#installing_drivers
resource "kubernetes_daemonset" "nvidia_driver" {
  count = local.install_nvidia_driver ? 1 : 0
  metadata {
    name      = "nvidia-driver-installer"
    namespace = "kube-system"
    labels = {
      k8s-app = "nvidia-driver-installer"
    }
  }

  spec {
    selector {
      match_labels = {
        k8s-app = "nvidia-driver-installer"
      }
    }

    template {
      metadata {
        labels = {
          name    = "nvidia-driver-installer"
          k8s-app = "nvidia-driver-installer"
        }
      }

      spec {
        priority_class_name = "system-node-critical"
        affinity {
          node_affinity {
            required_during_scheduling_ignored_during_execution {
              node_selector_term {
                match_expressions {
                  key      = "cloud.google.com/gke-accelerator"
                  operator = "Exists"
                }
              }
            }
          }
        }
        toleration {
          operator = "Exists"
        }
        host_network = true
        host_pid     = true

        volume {
          name = "dev"
          host_path {
            path = "/dev"
          }
        }
        volume {
          name = "vulkan-icd-mount"
          host_path {
            path = "/home/kubernetes/bin/nvidia/vulkan/icd.d"
          }
        }
        volume {
          name = "nvidia-install-dir-host"
          host_path {
            path = "/home/kubernetes/bin/nvidia"
          }
        }

        volume {
          name = "root-mount"
          host_path {
            path = "/"
          }
        }

        volume {
          name = "cos-tools"
          host_path {
            path = "/var/lib/cos-tools"
          }
        }

        volume {
          name = "nvidia-config"
          host_path {
            path = "/etc/nvidia"
          }
        }

        container {
          image = "gcr.io/google-containers/pause:2.0"
          name  = "pause"
        }

        init_container {
          image             = "cos-nvidia-installer:fixed"
          image_pull_policy = "Never"
          name              = "nvidia-driver-installer"

          resources {
            requests = {
              cpu = "0.15"
            }
          }

          security_context {
            privileged = true
          }

          env {
            name  = "NVIDIA_INSTALL_DIR_HOST"
            value = "/home/kubernetes/bin/nvidia"
          }

          env {
            name  = "NVIDIA_INSTALL_DIR_CONTAINER"
            value = "/usr/local/nvidia"
          }
          env {
            name  = "VULKAN_ICD_DIR_HOST"
            value = "/home/kubernetes/bin/nvidia/vulkan/icd.d"
          }
          env {
            name  = "VULKAN_ICD_DIR_CONTAINER"
            value = "/etc/vulkan/icd.d"
          }
          env {
            name  = "ROOT_MOUNT_DIR"
            value = "/root"
          }

          env {
            name  = "COS_TOOLS_DIR_HOST"
            value = "/var/lib/cos-tools"
          }

          env {
            name  = "COS_TOOLS_DIR_CONTAINER"
            value = "/build/cos-tools"
          }

          volume_mount {
            name       = "nvidia-install-dir-host"
            mount_path = "/usr/local/nvidia"
          }

          volume_mount {
            name       = "vulkan-icd-mount"
            mount_path = "/etc/vulkan/icd.d"
          }

          volume_mount {
            name       = "dev"
            mount_path = "/dev"
          }

          volume_mount {
            name       = "root-mount"
            mount_path = "/root"
          }

          volume_mount {
            name       = "cos-tools"
            mount_path = "/build/cos-tools"
          }

          command = ["/cos-gpu-installer", "install", "--version=latest"]
        }

        init_container {
          image = "gcr.io/gke-release/nvidia-partition-gpu@sha256:c54fd003948fac687c2a93a55ea6e4d47ffbd641278a9191e75e822fe72471c2"
          name  = "partition-gpus"

          env {
            name  = "LD_LIBRARY_PATH"
            value = "/usr/local/nvidia/lib64"
          }

          resources {
            requests = {
              cpu = "0.15"
            }
          }

          security_context {
            privileged = true
          }

          volume_mount {
            name       = "nvidia-install-dir-host"
            mount_path = "/usr/local/nvidia"
          }

          volume_mount {
            name       = "dev"
            mount_path = "/dev"
          }

          volume_mount {
            name       = "nvidia-config"
            mount_path = "/etc/nvidia"
          }
        }
      }
    }
  }
}
