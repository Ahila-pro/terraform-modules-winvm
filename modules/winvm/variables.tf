variable "name" {}
variable "location" {}  
variable "resource_group_name" {}
variable "admin_username" {}
variable "admin_password" {}        
variable "computer_name" {}
variable "size" {}
variable "provision_vm_agent" {}
variable "enable_automatic_updates" {}
variable "nic_id"{}
variable "os_disk" {
  description = "Configuration for the OS disk"
  type = object({
    caching              = string
    storage_account_type = string
  })
}

variable "source_image_reference" {
  description = "Image reference for the VM"
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

