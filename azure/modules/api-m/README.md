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
}```

## Input Variables

| Name | Description | Type | Default | Required |
|---|---|---|---|---|
| `name` | The name of the API Management instance. | `string` | n/a | yes |
| `resource_group_name` | The name of the resource group. | `string` | n/a | yes |
| `location` | The Azure region. | `string` | n/a | yes |
| `sku_name` | The SKU of the API Management instance. | `string` | n/a | yes |  Valid values: "Developer", "Basic", "Standard", "Premium", "Consumption" |
| `virtual_network_enabled` | Whether to enable virtual network integration. | `bool` | `false` | no |
| `virtual_network_subnet_id` | The ID of the subnet for virtual network integration. Required if `virtual_network_enabled` is `true`. | `string` | `null` | no |
| `capacity` | The number of scale units for the API Management instance. Only applicable for certain SKUs. | `number` | `1` | no |
| `publisher_name` | The name of the publisher. | `string` | `"Organization"` | no |
| `publisher_email` | The email address of the publisher. | `string` | `"email@example.com"` | no |
| `additional_locations` | A map of additional locations for the API Management instance (for multi-region deployments). | `map(object({ location = string, capacity = number }))` | `{}` | no |
| `gateway_disabled` | Whether to disable the gateway. | `bool` | `false` | no |
| `enable_client_certificate` | Whether to enable client certificate authentication. | `bool` | `false` | no |
| `hostname_configuration` | Configuration of custom hostnames. | `list(object({ host_name = string, certificate_id = string, negotiate_client_certificate = bool }))` | `[]` | no |
| `api_type` | The type of the API. Possible values are `graphql` and `rest`. Defaults to `rest`. | `string` | `"rest"` | no |
| `tags` | A map of tags to apply. | `map(string)` | `{}` | no |
| `identity` | An identity block as defined below, enabling Managed Identity. Example: `{ type = "SystemAssigned" }` or `{ type = "UserAssigned", identity_ids = ["/subscriptions/..../resourceGroups/..../providers/Microsoft.ManagedIdentity/userAssignedIdentities/...."] }` | `object({ type = string, identity_ids = optional(list(string)) })` | `null` | no |

## Outputs

| Name | Description | Type |
|---|---|---|
| `id` | The ID of the API Management instance. | `string` |
| `name` | The name of the API Management instance. | `string` |
| `gateway_url` | The URL of the API Management gateway. | `string` |
| `public_ip_addresses` | List of public IP addresses associated with the API Management instance. | `list(string)` |
| `private_ip_addresses` | List of private IP addresses associated with the API Management instance (if VNet integration is enabled). | `list(string)` |
| `identity` | The identity block of the API Management instance. Contains details like the principal ID for System Assigned identities, or the list of User Assigned Client IDs. | `object` |
