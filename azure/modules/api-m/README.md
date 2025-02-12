# Azure API Management Module

This Terraform module deploys an Azure API Management instance. It allows you to configure various aspects of the API Management service, including its name, resource group, location, SKU, and other settings.

## Overview

This module simplifies the deployment of an Azure API Management instance. It handles the creation of the necessary resources, including the API Management service itself. It also allows configuration of important properties such as SKU, virtual network integration, and management API settings.

## Usage

```terraform
module "apim" {
  source = "path/to/your/module/azure/modules/api-m" # Replace with the actual path

  name                = "my-apim-instance"
  resource_group_name = "rg-my-resources"
  location            = "West US 2"
  sku_name            = "Developer" # Or "Basic", "Standard", "Premium", "Consumption"

  # Optional parameters (see variables.tf for details)
  virtual_network_enabled = true
  virtual_network_subnet_id = "/subscriptions/xxxx/resourceGroups/xxxx/providers/Microsoft.Network/virtualNetworks/xxxx/subnets/xxxx"
  # ... other optional parameters
}
