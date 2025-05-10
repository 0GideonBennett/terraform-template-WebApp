#Azure Key Vault + Secret

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "rg" {
  name     = "keyvault-rg"
  location = "eastus"
}

resource "azurerm_key_vault" "vault" {
  name                     = "your-vault12345"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  tenant_id                = data.azurerm_client_config.current.tenant_id
  sku_name                 = "standard"
  soft_delete_enabled      = true
  purge_protection_enabled = false
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_access_policy" "me" {
  key_vault_id = azurerm_key_vault.vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = ["Set", "Get", "List"]
}

resource "azurerm_key_vault_secret" "secret" {
  name         = "your-secret"
  value        = "SuperSecret123!"
  key_vault_id = azurerm_key_vault.vault.id
}
