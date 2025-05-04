module "resource-group" {
  source   = "./modules/resource-group"
  name     = "modules-rgp"
  location = "Central India"
}

module "stg-account" {
  source                  = "./modules/stg-account"
  resource_group_name     = module.resource-group.name
  location                = module.resource-group.location
  name                    = "modulestgaccountttstg"
  account_tier            = "Standard"
  account_replication_type = "GRS"
  
}

module "vnet" {   
  source              = "./modules/vnet"
  name                = "modules-vnet"
  resource_group_name     = module.resource-group.name
  location            = module.resource-group.location
  address_space       = ["10.0.0.0/16"]
  
}

module "subnet" {
  source              = "./modules/subnet"
  name                = "modules-subnet"
  resource_group_name     = module.resource-group.name
  location            = module.resource-group.location
  vnet_name = module.vnet.vnet-name
  address_space       = ["10.0.1.0/24"]
  
}

module "nsg" {
  source              = "./modules/nsg"
  name                = "module-nsg"
  location            = module.resource-group.location
  resource_group_name = module.resource-group.name

  security_rules = [
    {
      name                       = "RDP"
      priority                   = 1001
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "HTTP"
      priority                   = 1002
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}

module "pip" {
  source              = "./modules/pip"
  name                = "module-pip"
  location            = module.resource-group.location
  resource_group_name = module.resource-group.name
  allocation_method   = "Static"
  sku                 = "Basic"
  
}

module "nic" {
  source              = "./modules/nic"
  name                = "module-nic"
  location            = module.resource-group.location
  resource_group_name = module.resource-group.name
  ip_configuration = {
    name                          = "internal"
    subnet_id                     = module.subnet.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = module.pip.public_ip_id
  }
  #For nsg association to nic passing the nsg id
  network_security_group_id = module.nsg.network_security_group_id
}

module "winvm" {
  source              = "./modules/winvm"
  name                = "module-winvm"
  location            = module.resource-group.location
  resource_group_name = module.resource-group.name
  size                = "Standard_B2ms"
  admin_username      = "adminuser"
  admin_password      = "Welcome@123$"
  computer_name       = "winvm"
  provision_vm_agent  = true
  enable_automatic_updates = true
  
  os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }
  source_image_reference = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
 
  nic_id  = [module.nic.nic_id]
}



  

