variable "vm_defaults" {
    default = {
   web = {
      #"server_type": "web",
      #"application_type": "emerge",
      "os_type": "windows",
      "p_n_flag": "n",
      "host_project": "idyllic-slice-422610-p1",
      "service_project": "idyllic-slice-422610-p1",
      "network": "hub-vpc",
      "vm_name_suffix": "w01",
      "subnetwork": "hub-subnet",
      "machine_type": "f1-micro",
      "service_account": "236804750025-compute@developer.gserviceaccount.com",
      "metadata": {
        "p_n_flag": "n",
        "resource_prefix": "oam"
      },
      #"customer_code": "sg1",
      "boot_disk": {
        "image": "projects/debian-cloud/global/images/debian-12-bookworm-v20240312",
        "type": "pd-standard",
        "size": 20
      },
      "attached_disk": [
        {
          "type": "pd-standard",
          "name": "h",
          "size": 10
        },
        {
          "type": "pd-standard",
          "name": "l",
          "size": 20
        }
      ],
      "zone": "us-east4-c",
      "region": "us-east4"
    },
   kafka = {
      #"server_type": "kafka",
      #"application_type": "emerge",
      "os_type": "linux",
      "p_n_flag": "n",
      "vm_name_suffix": "k01",
      "host_project": "idyllic-slice-422610-p1",
      "service_project": "idyllic-slice-422610-p1",
      "network": "hub-vpc",
      "subnetwork": "hub-subnet",
      "machine_type": "f1-micro",
      "service_account": "236804750025-compute@developer.gserviceaccount.com",
      "metadata": {
        "p_n_flag": "n",
        "resource_prefix": "oam"
      },
      #"customer_code": "sg1",
      "boot_disk": {
        "image": "projects/debian-cloud/global/images/debian-12-bookworm-v20240312",
        "type": "pd-ssd",
        "size": 20
      },
      "attached_disk": [
        {
          "type": "pd-standard",
          "name": "h",
          "size": 10
        },
        {
          "type": "pd-standard",
          "name": "l",
          "size": 20
        }
      ],
      "zone": "us-east4-b",
      "region": "us-east4"
    }
    }
}