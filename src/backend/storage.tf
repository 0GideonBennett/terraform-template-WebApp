# Storage Account + Blob Container + Lifecycle Rules

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "storage-rg"
  location = "eastus"
}

resource "azurerm_storage_account" "storage" {
  name                     = "your-storacct01" # must be globally unique
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  name                  = "your-container"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_management_policy" "policy" {
  storage_account_id = azurerm_storage_account.storage.id

  rule {
    name    = "expire-logs"
    enabled = true
    filters {
      prefix_match = ["logs/"]
      blob_types   = ["blockBlob"]
    }
    actions {
      base_blob {
        delete_after_days_since_modification_greater_than = 30
      }
    }
  }
}
