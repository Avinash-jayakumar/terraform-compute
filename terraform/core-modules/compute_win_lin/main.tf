locals {
  application_flag = var.application_type == "emerge" ? "e" : "d"
  os_flag = var.os_type == "windows" ? "w" : "l"
  vm_name = format("oam%s%s%svyq%s%s", local.application_flag, var.p_n_flag, local.os_flag, var.customer_code, var.vm_name_suffix)
}



module "vm" {
  source     = "git::https://github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/compute-vm?ref=v30.0.0"
  project_id = var.service_project
  zone       = var.zone
  name       = local.vm_name
  network_interfaces = [{
    network    = var.network
    subnetwork = var.subnetwork
  }]
  instance_type = var.machine_type
  boot_disk = {
    initialize_params = {
      image = var.boot_disk.image
      type = var.boot_disk.type
      size = var.boot_disk.size
    }
  }
  attached_disks = var.attached_disk
  service_account = {
    email = var.service_account 
  }
  metadata = var.metadata
}