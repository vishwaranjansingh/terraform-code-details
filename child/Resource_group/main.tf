# This Terraform configuration defines an Azure Resource Group resource.
# It uses the "for_each" meta-argument to create multiple resource groups
# based on the "var.rg" variable, which should be a map or object containing
# the name and location for each resource group.
# Each resource group will be created with the specified name and location.

# Example usage:
# variable "rg" {
#   type = map(object({
#     name     = string
#     location = string
#   }))
# }

# The resource block below will iterate over each entry in var.rg and
# create a resource group accordingly.


resource "azurerm_resource_group" "rgs" {
    for_each = var.rg
    name = each.value.name
    location = each.value.location
  
}

