terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
    features {
      
    }
}

resource "azurerm_resource_group" "rgstorage" {
    name = "iactreinamento"
    location = "brazilsouth"
  
}


resource "azurerm_storage_account" "storagetf" {
    name = "tfstagestorageiac"
    resource_group_name = azurerm_resource_group.rgstorage.name
    location = "brazilsouth"
    access_tier = "Hot"
    account_tier = "Standard"
    account_replication_type = "LRS"
  
}

resource "azurerm_storage_container" "container" {
    name = "terraform"
    storage_account_name = azurerm_storage_account.storagetf.name
    depends_on = [
      azurerm_storage_account.storagetf
    ] 
}

output "blobstorage-name" {
    value = azurerm_storage_account.storagetf.name  
}

output "blobstorage-chave-primaria" {
    value = azurerm_storage_account.storagetf.primary_access_key
    sensitive = true
  
}

output "blobstorage-chave-secundaria" {
    value = azurerm_storage_account.storagetf.secondary_access_key
    sensitive = true
  
}


