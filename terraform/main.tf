# Just creating VMs
# cd ~/linuxfactory/infra/terraform && terraform apply --auto-approve
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone      = "ru-central1-a"
  folder_id = "b1gi4toldf8v97abnt34"  # yc config get folder-id
}

// ВМ
resource "yandex_compute_instance" "vm" {
  count       = 2  # count of VM
  name        = "vminstance-${count.index + 1}"
  zone        = "ru-central1-a"
  platform_id = "standard-v3" # тип процессора (Intel Broadwell)

  # https://yandex.cloud/en-ru/docs/compute/concepts/performance-levels
  resources {
    # core_fraction = 50 # Гарантированный % vCPU
    # cores         = 4
    # memory        = 4
    core_fraction = 20 # Гарантированный % vCPU
    cores         = 4
    memory        = 4
    # core_fraction = 20 # Гарантированный % vCPU
    # cores         = 2
    # memory        = 1
  }
  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = "fd84kp940dsrccckilj6"  # Ubuntu 22.04 LTS
      size     = "20"
    }
  }

  network_interface {
    subnet_id      = "e9b25s9ehhavtjgngl91"
    nat            = true
    # nat_ip_address = yandex_vpc_address.addr.external_ipv4_address[0].address
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}

// Печатаем внешний IP VM
# output "vm_ip_address-1" {
#   value = yandex_compute_instance.vm[0].network_interface.0.nat_ip_address
# }

output "vm_ip_addresses_all" {
    value = {
        for inx, vm in yandex_compute_instance.vm:
        "vminstance-${inx + 1}" => vm.network_interface.0.nat_ip_address
    }
}
