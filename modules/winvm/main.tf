resource "azurerm_windows_virtual_machine" "vm" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = var.nic_id
  provision_vm_agent  = var.provision_vm_agent
  enable_automatic_updates = var.enable_automatic_updates
 

  os_disk {
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer     = var.source_image_reference.offer
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }

  computer_name = var.computer_name
}

resource "azurerm_virtual_machine_extension" "iis_install" {
  name                 = "IISInstall"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
    {
      "commandToExecute": "powershell -Command Install-WindowsFeature -Name Web-Server -IncludeManagementTools"
    }
SETTINGS

  depends_on = [azurerm_windows_virtual_machine.vm]
}