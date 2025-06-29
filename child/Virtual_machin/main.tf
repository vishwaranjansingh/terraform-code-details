resource "azurerm_linux_virtual_machine" "vm" {
    for_each = var.virtual
    name =each.value.name
    resource_group_name = each.value.resource_group_name
      location =each.value.location
      size = each.value.size
      admin_username = each.value.admin_username
      admin_password = each.value.admin_password
# 
  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id
  ]
  ## This is for storage- date storage
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "${each.value.name}-osdisk"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
   disable_password_authentication = false
}

  resource "azurerm_public_ip" "public_ip" {
for_each = var.virtual
  name                = "${each.value.name}-public-ip"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}
resource "azurerm_network_interface" "nic" {

for_each = var.virtual
  name                = "${each.value.name}-nic"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = each.value.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip[each.key].id
  }
}


# resource "null_resource" "deploy_build" {
#   depends_on = [azurerm_linux_virtual_machine.vm]

#   provisioner "remote-exec" {
#     connection {
#       type        = "ssh"
#       host        = azurerm_linux_virtual_machine.vm.public_ip_address
#       user        = "vishwavm"
#       private_key = file(var.private_key_path)   # tumhara ssh private key ka path
#     }

#     inline = [
#       "sudo cp -r /home/vishwavm/build/* /var/www/html/",
#       "sudo systemctl reload nginx"
#     ]
#   }
# }

