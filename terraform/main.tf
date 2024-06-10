

locals {
  json_directory = ["/vm_config/application", "/vm_config/database"]
  json_files     = flatten([for dir in local.json_directory : fileset(path.module, "${dir}/*.json")])
  json_data      = { for f in local.json_files : trimsuffix(basename(f), ".json") => { for a, b in jsondecode(file("${path.module}/${f}")) : b.server_type => b } }
  json = flatten([for k, v in local.json_data : [for a, b in v : {
    file_name        = k
    region           = b.region
    application_type = b.application_type
    p_n_flag         = b.p_n_flag
    vm_name_suffix   = b.vm_name_suffix
    server_type      = b.server_type
    boot_disk        = b.boot_disk
    os_type          = b.os_type
    host_project     = b.host_project
    service_project  = b.service_project
    network          = b.network
    subnetwork       = b.subnetwork
    machine_type     = b.machine_type
    service_account  = b.service_account
    metadata         = b.metadata
    customer_code    = b.customer_code
    attached_disk    = b.attached_disk
    zone             = b.zone
    }
    ]
  ])

}

module "compute" {
  source = "./core-modules/compute_win_lin/"

  for_each         = tomap({ for v in local.json : "${v.file_name}_${v.server_type}" => v })
  application_type = each.value.application_type
  p_n_flag         = each.value.p_n_flag
  vm_name_suffix   = each.value.vm_name_suffix
  server_type      = each.value.server_type
  boot_disk        = each.value.boot_disk
  os_type          = each.value.os_type
  host_project     = each.value.host_project
  service_project  = each.value.service_project
  network          = each.value.network
  subnetwork       = each.value.subnetwork
  machine_type     = each.value.machine_type
  service_account  = each.value.service_account
  metadata         = each.value.metadata
  customer_code    = each.value.customer_code
  attached_disk    = each.value.attached_disk
  zone             = each.value.zone
  region           = each.value.region

}