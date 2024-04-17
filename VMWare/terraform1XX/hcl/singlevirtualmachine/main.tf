#####################################################################
##
##      Created 4/16/24 by glopez. for singlevirtualmachine
##
#####################################################################

#terraform {
#  required_version = "~> 0.12"
#}

provider "vsphere" {
  version = "2.7.0"
  allow_unverified_ssl = true
}


data "vsphere_virtual_machine" "virtual_machine_template" {
  name          = var.virtual_machine_template_name
  datacenter_id = data.vsphere_datacenter.virtual_machine_datacenter.id
}

data "vsphere_datacenter" "virtual_machine_datacenter" {
  name = var.virtual_machine_datacenter_name
}

data "vsphere_datacenter" "virtual_machine_datacenter_name" {
  name = var.virtual_machine_datacenter_name
}

data "vsphere_datastore" "virtual_machine_datastore" {
  name          = var.virtual_machine_datastore_name
  datacenter_id = data.vsphere_datacenter.virtual_machine_datacenter.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.clus_name
  datacenter_id = data.vsphere_datacenter.virtual_machine_datacenter.id
}

data "vsphere_network" "network" {
  name          = var.nw_name
  datacenter_id = data.vsphere_datacenter.virtual_machine_datacenter.id
}

resource "vsphere_virtual_machine" "virtual_machine" {
  name          = var.virtual_machine_name
  datastore_id  = data.vsphere_datastore.virtual_machine_datastore.id
  num_cpus      = var.virtual_machine_number_of_vcpu
  memory        = var.virtual_machine_memory
  guest_id      = data.vsphere_virtual_machine.virtual_machine_template.guest_id
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  
  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.virtual_machine_template.network_interface_types[0]
  }
  
  clone {
    template_uuid = data.vsphere_virtual_machine.virtual_machine_template.id
    customize {
        linux_options {
          host_name = "HostnameModificado"
          domain    = "mjarquin.com"
        }
        network_interface {
          ipv4_address = "192.168.0.2"
          ipv4_netmask = 24
        }
      }
  }
  disk {
    label = var.virtual_machine_disk_name
    size = var.virtual_machine_disk_size
  }
}