terraform {
  backend "azurerm" {
    resource_group_name = "iactreinamento"
    storage_account_name = "tfstagestorageiac"
    container_name = "terraform"
    key = "tfstagestorageiac"  
    }
}

provider "azurerm" {
    features {
      
    }
  
}
resource "azurerm_storage_account" "storageaccount" {
  name                     = "stgiactreinamento"
  resource_group_name      = "${var.resourcegroupName}"
  location                 = "${var.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}





resource "azurerm_storage_container" "pysparkcontainer" {
  name                  = "pyspark-code"
  storage_account_name  = azurerm_storage_account.storageaccount.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "blob" {
  name                   = "azHDInS-code/pyspark/job_pyspark_from_tf.py"
  storage_account_name   = azurerm_storage_account.storageaccount.name
  storage_container_name = azurerm_storage_container.pysparkcontainer.name
  type                   = "Block"
  source                 = "../job_spark.py"
}