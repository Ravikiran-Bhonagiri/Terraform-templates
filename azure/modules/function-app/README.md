# Azure Function App Module

This Terraform module deploys an Azure Function App. It allows customization of various aspects of the Function App, including the name, resource group, storage account connection, and function app settings.

## Overview

This module simplifies the deployment of an Azure Function App. It handles the creation of the necessary resources, including the Function App itself and its associated App Service Plan (if one isn't provided). It also allows for configuring settings, environment variables, and other important properties.

## Usage

```terraform
module "function_app" {
  source = "path/to/module/azure/modules/function-app" # Replace with the actual path

  name                = "my-function-app"
  resource_group_name = "rg-my-resources"
  location            = "West US 2"
  storage_account_connection_string = "Endpoint=[https://mystorage.blob.core.windows.net/;AccountName=mystorage;AccountKey=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx](https://www.google.com/search?q=https://mystorage.blob.core.windows.net/%3BAccountName%3Dmystorage%3BAccountKey%3Dxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx)"

  # Optional parameters (see variables.tf for details)
  app_service_plan_id = "/subscriptions/xxxx/resourceGroups/xxxx/providers/Microsoft.Web/serverfarms/xxxx" # Or provide app_service_plan_name and sku
  app_settings = {
    "AzureWebJobsStorage" = "Endpoint=[https://mystorage.blob.core.windows.net/;AccountName=mystorage;AccountKey=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx](https://www.google.com/search?q=https://mystorage.blob.core.windows.net/%3BAccountName%3Dmystorage%3BAccountKey%3Dxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx)"
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
  site_config = {
    always_on = true
  }
  https_only = true
  client_affinity_enabled = false
  # ... other optional parameters
}```

## Input Variables

| Name | Description | Type | Default | Required |
|---|---|---|---|---|
| `name` | The name of the function app. | `string` | n/a | yes |
| `resource_group_name` | The name of the resource group in which to create the function app. | `string` | n/a | yes |
| `location` | The Azure region in which to create the function app. | `string` | n/a | yes |
| `storage_account_connection_string` | The connection string for the storage account to use with the function app. | `string` | n/a | yes |
| `app_service_plan_id` | The ID of the App Service Plan to use for the function app.  If not provided, a new App Service Plan will be created. | `string` | `null` | no |
| `app_service_plan_name` | The name of the App Service Plan to create. Required if `app_service_plan_id` is not provided. | `string` | `null` | no |
| `sku` | The SKU of the App Service Plan to create. Required if `app_service_plan_id` is not provided.  Valid values include: `F1` (Free), `S1`, `P1`, etc. | `string` | `"S1"` | no |
| `app_settings` | A map of key-value pairs to set as application settings for the function app. | `map(string)` | `{}` | no |
| `site_config` | A map containing site configuration settings.  See the Azure documentation for available options. | `map(string)` | `{}` | no |
| `https_only` | Whether to force HTTPS for the function app. | `bool` | `false` | no |
| `client_affinity_enabled` | Enables or disables client affinity. | `bool` | `false` | no |
| `identity` | An identity block as defined below, enabling Managed Identity.  Example: `{ type = "SystemAssigned" }` or `{ type = "UserAssigned", identity_ids = ["/subscriptions/..../resourceGroups/..../providers/Microsoft.ManagedIdentity/userAssignedIdentities/...."] }` | `object({ type = string, identity_ids = optional(list(string)) })` | `null` | no |
| `tags` | A map of tags to apply to the function app. | `map(string)` | `{}` | no |
| `storage_account_name` | Name of the storage account (used if connection string isn't provided). | `string` | `null` | no |
| `storage_account_access_key` | Access key for the storage account (used if connection string isn't provided). | `string` | `null` | no |
| `storage_container_name` | Name of the storage container (used if connection string isn't provided). | `string` | `null` | no |
| `storage_share_name` | Name of the storage share (used if connection string isn't provided). | `string` | `null` | no |
| `function_app_kind` | The kind of the function app. Defaults to `functionapp`. | `string` | `"functionapp"` | no |
| `always_on` | Enables or disables the always on setting for the App Service Plan. Only applicable when creating a new App Service Plan. | `bool` | `false` | no |
| `minimum_elastic_instance_count` | The minimum number of instances for the function app if using a Consumption/Elastic Premium plan. | `number` | `null` | no |
| `maximum_elastic_instance_count` | The maximum number of instances for the function app if using a Consumption/Elastic Premium plan. | `number` | `null` | no |
| `public_network_access_enabled` | Whether or not public network access is allowed for this Function App. Possible values are `true`, `false` or `null` (the default). When set to `null` the access is controlled by the network access configuration on the Function App's App Service Plan. | `bool` | `null` | no |


## Outputs

| Name | Description | Type |
|---|---|---|
| `id` | The ID of the function app. | `string` |
| `name` | The name of the function app. | `string` |
| `host_name` | The hostname of the function app. | `string` |
| `default_site_hostname` | The default site hostname of the function app. | `string` |
| `app_service_plan_id` | The ID of the App Service Plan used by the function app. | `string` |
| `storage_account_connection_string` | The connection string for the storage account used by the function app. | `string` |
| `identity` | The identity block of the function app.  Contains details like the principal ID for System Assigned identities, or the list of User Assigned Client IDs. | `object` |
