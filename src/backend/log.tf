#Log Analytics Workspace + Diagnostics Settings for a VM
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "log-rg"
  location = "eastus"
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "your-law"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
