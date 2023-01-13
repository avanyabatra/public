terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.38.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {
  }
}

variable "stg_count" {
  default     = "1"
  type        = string
}

#stg_count = [1,2,3,4,5,6,7,8,9,10]

#variable "stg_count" {
 # type = list(any)
  #default = [1,2,3,4,5,6,7,8,9]
#}

resource "azurerm_resource_group" "inv-use-dev-0001-rg" {
    name = "inv-use-dev-0001-rg"
    location = "East US"
}

resource "azurerm_storage_account" "invusedevstg0001" {
  name = "invusedevstg0001"
  location = azurerm_resource_group.inv-use-dev-0001-rg.location
  resource_group_name = azurerm_resource_group.inv-use-dev-0001-rg.name
  account_tier  = "Standard"
  account_replication_type = "LRS"
  depends_on = [
    azurerm_resource_group.inv-use-dev-0001-rg
  ]
}

resource "azurerm_storage_account" "name" {
  #for_each   = { for i in var.stg_count : "key_${i}" => i }
  count = var.stg_count
  name = "invusedevstg000${count.index}"
  location = azurerm_resource_group.inv-use-dev-0001-rg.location
  resource_group_name = azurerm_resource_group.inv-use-dev-0001-rg.name
  account_tier  = "Standard"
  account_replication_type = "LRS"
  depends_on = [
    azurerm_resource_group.inv-use-dev-0001-rg
  ]
}