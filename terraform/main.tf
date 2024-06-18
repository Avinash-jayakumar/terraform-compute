

locals {
  json_directory = ["/vm_config/application", "/vm_config/database"]
  json_files     = flatten([for dir in local.json_directory : fileset(path.module, "${dir}/*.json")])
  json_data      = { for f in local.json_files : trimsuffix(basename(f), ".json") => { for a, b in jsondecode(file("${path.module}/${f}")) : b.server_type => b } }
  json = flatten([for k, v in local.json_data : [for a, b in v : {
    file_name        = k
    application_type = b.application_type
    server_type      = b.server_type
    customer_code    = b.customer_code
    region           = try(b.region , var.vm_defaults["${b.server_type}"]["region"])
    p_n_flag         = try(b.p_n_flag , var.vm_defaults["${b.server_type}"]["p_n_flag"])
    vm_name_suffix   = try(b.vm_name_suffix , var.vm_defaults["${b.server_type}"]["vm_name_suffix"])
    boot_disk        = try(b.boot_disk , var.vm_defaults["${b.server_type}"]["boot_disk"])
    os_type          = try(b.os_type , var.vm_defaults["${b.server_type}"]["os_type"])
    host_project     = try(b.host_project , var.vm_defaults["${b.server_type}"]["host_project"])
    service_project  = try(b.service_project , var.vm_defaults["${b.server_type}"]["service_project"])
    network          = try(b.network , var.vm_defaults["${b.server_type}"]["network"])
    subnetwork       = try(b.subnetwork , var.vm_defaults["${b.server_type}"]["subnetwork"])
    machine_type     = try(b.machine_type , var.vm_defaults["${b.server_type}"]["machine_type"])
    service_account  = try(b.service_account , var.vm_defaults["${b.server_type}"]["service_account"])
    metadata         = try(b.metadata , var.vm_defaults["${b.server_type}"]["metadata"])
    attached_disk    = try(b.attached_disk , var.vm_defaults["${b.server_type}"]["attached_disk"])
    zone             = try(b.zone , var.vm_defaults["${b.server_type}"]["zone"])
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

output "test" {
  value = local.json
}