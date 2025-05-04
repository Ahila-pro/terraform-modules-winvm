variable "name" {}
variable "location" {}  
variable "resource_group_name" {}
variable "ip_configuration" {
  description = "IP configuration settings for the NIC"
  type = object({
    name                          = string
    subnet_id                     = string
    private_ip_address_allocation = string
    public_ip_address_id          = string
  })
}

#for nsg association
# This variable is used to pass the NSG ID to the NIC module for association
variable "network_security_group_id" {
  description = "The ID of the NSG to associate with the NIC"
  type        = string
  default     = null
}
