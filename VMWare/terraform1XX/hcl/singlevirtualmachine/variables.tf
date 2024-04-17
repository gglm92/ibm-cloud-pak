#####################################################################
##
##      Created 4/16/24 by glopez. for singlevirtualmachine
##
#####################################################################

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
  type = string
  description = "Generated"
}

variable "virtual_machine_datacenter_name" {
  type = string
  description = "Generated"
}

variable "virtual_machine_datastore_name" {
  type = string
  description = "Generated"
}

variable "clus_name" {
  description = "Nombre del Cluster"
  type = string
}

variable "nw_name" {
  description = "Nombre de la Network"
  type = string
}

