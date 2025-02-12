# Azure App Service Plan Module

This Terraform module deploys an Azure App Service Plan. It allows you to configure various aspects of the App Service Plan, including its name, resource group, location, SKU, and other settings.

## Overview

This module simplifies the deployment of an Azure App Service Plan. It handles the creation of the necessary resources, including the App Service Plan itself. It allows you to configure important properties such as SKU, operating system, and scaling options.

## Usage

This section provides detailed examples of how to use the module with different configurations.

**Basic Usage (Linux, Standard SKU):**

This example deploys a Linux App Service Plan with a Standard S1 SKU.


module "app_service_plan" {
  source = "path/to/your/module/azure/modules/app-service-plan" # Replace with the actual path

  name                = "my-app-service-plan"
  resource_group_name = "rg-my-resources"
  location            = "West US 2"
  sku {
    name = "S1"
    tier = "Standard"
  }
}


module "app_service_plan" {
  source = "path/to/your/module/azure/modules/app-service-plan"

  name                = "my-windows-app-service-plan"
  resource_group_name = "rg-my-resources"
  location            = "West US 2"
  kind = "app"  # or os_type = "Windows"
  sku {
    name = "S1"
    tier = "Standard"
  }
}


module "app_service_plan" {
  source = "path/to/your/module/azure/modules/app-service-plan"

  name                = "my-scaled-app-service-plan"
  resource_group_name = "rg-my-resources"
  location            = "West US 2"
  sku {
    name = "S1"
    tier = "Standard"
  }
  capacity = 3
}


module "app_service_plan" {
  source = "path/to/your/module/azure/modules/app-service-plan"

  name                = "my-always-on-app-service-plan"
  resource_group_name = "rg-my-resources"
  location            = "West US 2"
  sku {
    name = "S1"
    tier = "Standard"
  }
  always_on = true
}



