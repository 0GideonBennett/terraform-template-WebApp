#. Simple App Service + Plan (No DB)

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "appsvc-rg"
  location = "eastus"
}

resource "azurerm_app_service_plan" "plan" {
  name                = "your-app-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "app" {
  name                = "your-webapp1234" # must be globally unique
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.plan.id

  site_config {
    linux_fx_version = "PYTHON|3.9"
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}
