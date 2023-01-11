module "auto_cidr" {
  count        = var.enable_auto_cidr ? 1 : 0
  source       = "../../azure/auto-cidr"
  network_mask = var.network_mask
  # what if we set a default like this?
  # on Azure, don't even show "slash 18, slash 20. 16K IPS, and the option to put in your own"
  # is that burrying the devops
  # subnetwork_mask = "/18"
  virtual_network_id = var.virtual_network_id
}
