provider "azurerm" {
  features {}
}

# Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "my-resource-group"
  location = "East US"
}

# Create Storage Account
resource "azurerm_storage_account" "sa" {
  name                     = "mystorageaccount"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create App Service Plan
resource "azurerm_app_service_plan" "asp" {
  name                = "my-app-service-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "FunctionApp"
  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

# Call the Function App Module
module "function_app" {
  source = "./modules/function_app"

  # Required Variables
  function_app_name          = "my-simple-function-app"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  app_service_plan_id        = azurerm_app_service_plan.asp.id
  storage_account_name       = azurerm_storage_account.sa.name
  storage_account_access_key = azurerm_storage_account.sa.primary_access_key

  # Optional Variables
  function_app_version = "~4"
  function_app_runtime = "node"
  always_on            = true

  tags = {
    Environment = "Production"
    Team        = "DevOps"
  }
}
