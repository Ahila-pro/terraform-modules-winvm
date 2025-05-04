resource "azurerm_network_interface" "nic" {
  name                =var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = var.ip_configuration.name
    subnet_id                     = var.ip_configuration.subnet_id
    private_ip_address_allocation = var.ip_configuration.private_ip_address_allocation
    public_ip_address_id          = var.ip_configuration.public_ip_address_id
  }
  
}

#nsg assocation to nic
# This resource associates the Network Security Group (NSG) with the Network Interface (NIC)
resource "azurerm_network_interface_security_group_association" "nsg_assoc" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = var.network_security_group_id
}