terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.31.0"
    }
  }

}

provider "azurerm" {
  features {}
  subscription_id = "bf1596c6-e1fe-4c77-93ea-0e7bc5739622"
}