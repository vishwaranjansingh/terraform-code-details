resource "azurerm_resource_group" "rgs" {
    for_each = var.rg
    name = each.value.name
    location = each.value.location
  
}

resource "azurerm_resource_group" "rgs" {
    for_each = var.rg
    name = each.value.name
    location = each.value.location
  
}