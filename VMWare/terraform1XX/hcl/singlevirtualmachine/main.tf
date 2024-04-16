#####################################################################
##
##      Created 4/16/24 by glopez.
##
#####################################################################

terraform {
  required_version = "~> 0.12"
}

provider "vsphere" {
  version = "~> 1.24"
}

variable "virtual_machine_name" {
  type = string
  description = "Virtual machine name for virtual_machine"
}

variable "virtual_machine_number_of_vcpu" {
  type = string
  description = "Number of virtual cpu's."
}

variable "virtual_machine_memory" {
  type = string
  description = "Memory allocation."
}

variable "virtual_machine_disk_name" {
  type = string
  description = "The name of the disk. Forces a new disk if changed. This should only be a longer path if attaching an external disk."
}

variable "virtual_machine_disk_size" {
  type = string
  description = "The size of the disk, in GiB."
}

variable "virtual_machine_template_name" {
  type = "string"
  description = "Generated"
}

variable "virtual_machine_datacenter_name" {
  type = "string"
  description = "Generated"
}

variable "virtual_machine_datastore_name" {
  type = "string"
  description = "Generated"
}

variable "resource_pool_cluster_name" {
  type = string
  description = "Cluster name"
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

data "vsphere_resource_pool" "resource_pool_cluster" {
  name          = var.resource_pool_cluster_name
  datacenter_id = data.vsphere_datacenter.virtual_machine_datacenter_name.id
}

resource "vsphere_virtual_machine" "virtual_machine" {
  name          = var.virtual_machine_name
  datastore_id  = data.vsphere_datastore.virtual_machine_datastore.id
  num_cpus      = var.virtual_machine_number_of_vcpu
  memory        = var.virtual_machine_memory
  guest_id = data.vsphere_virtual_machine.virtual_machine_template.guest_id
  resource_pool_id = data.vsphere_resource_pool.resource_pool_cluster.id
  clone {
    template_uuid = data.vsphere_virtual_machine.virtual_machine_template.id
  }
  disk {
    label = var.virtual_machine_disk_name
    size = var.virtual_machine_disk_size
  }
}