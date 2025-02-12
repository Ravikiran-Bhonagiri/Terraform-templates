# Azure App Service Module

This Terraform module deploys an Azure App Service (Web App or Function App). It allows you to configure various aspects of the App Service, including its name, resource group, location, App Service Plan association, site configuration, and other settings.

## Overview

This module simplifies the deployment of an Azure App Service. It handles the creation of the necessary resources, including the App Service itself. It allows you to configure important properties such as the App Service Plan it runs on, application settings, site configuration, and managed identity.  It supports both Linux and Windows App Services.

## Usage

This section provides detailed examples of how to use the module with different configurations.

**Basic Web App (Linux, Standard SKU):**

This example deploys a basic Linux Web App.

```terraform
module "app_service" {
  source = "path/to/your/module/azure/modules/app-service" # Replace with the actual path

  name                = "my-web-app"
  resource_group_name = "rg-my-resources"
  location            = "West US 2"
  app_service_plan_id = module.app_service_plan.id # ID of your App Service Plan
  kind = "app" # For Web App
  site_config {
    always_on = true # Optional: Keep the app always running
  }
}


module "app_service_plan" { # Example App Service Plan module
  source = "path/to/your/app_service_plan_module"
  name = "example-asp"
  resource_group_name = "rg-my-resources"
  location = "West US 2"
  sku {
    name = "S1"
    tier = "Standard"
  }
}

```

**Windows Web App:**

```terraform
module "app_service" {
  source = "path/to/your/module/azure/modules/app-service"

  name                = "my-windows-web-app"
  resource_group_name = "rg-my-resources"
  location            = "West US 2"
  app_service_plan_id = module.app_service_plan.id
  kind = "app"
  site_config {
    windows_fx_version = "DOCKER|microsoft/iis:windowsservercore-ltsc2022" # Example Docker image for Windows
  }
}

```

---

**Linux Function App:**

```terraform
module "app_service" {
  source = "path/to/your/module/azure/modules/app-service"

  name                = "my-function-app"
  resource_group_name = "rg-my-resources"
  location            = "West US 2"
  app_service_plan_id = module.app_service_plan.id
  kind = "functionapp" # For Function App
  site_config {
    linux_fx_version = "DOCKER|[mcr.microsoft.com/azure-functions/dotnet:6](https://www.google.com/search?q=https://mcr.microsoft.com/azure-functions/dotnet:6)" # Example Docker image for .NET 6 Function App
  }
  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "dotnet"
  }
}

```

**Input Variables: **

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `name` | The name of the App Service. | `string` | n/a | yes |
| `resource_group_name` | The name of the resource group. | `string` | n/a | yes |
| `location` | The Azure region. | `string` | n/a | yes |
| `app_service_plan_id` | The ID of the App Service Plan. | `string` | n/a | yes |
| `kind` | The kind of App Service to create. Possible values are `app` (for Web App) and `functionapp` (for Function App). | `string` | `"app"` | no |
| `client_affinity_enabled` | Enables or disables client affinity. | `bool` | `false` | no |
| `https_only` | Whether to force HTTPS for the app. | `bool` | `false` | no |
| `site_config` | A `site_config` block as defined below. | `object` | `{}` | no |
| `app_settings` | A map of key-value pairs to set as application settings. | `map(string)` | `{}` | no |
| `identity` | An `identity` block as defined below, enabling Managed Identity. | `object({ type = string, identity_ids = optional(list(string)) })` | `null` | no |
| `hostname_bindings` | A list of `hostname_bindings` blocks as defined below. | `list(object({ hostname = string }))` | `[]` | no |
| `deployment_slots` | A list of `deployment_slots` blocks as defined below. | `list(object({ name = string, site_config = optional(object), app_settings = optional(map(string)) }))` | `[]` | no |
| `tags` | A map of tags to apply. | `map(string)` | `{}` | no |

---

## Detailed Explanation of `app_settings` and `site_config`

### `app_settings` (Application Settings)

The `app_settings` input variable takes a map of key-value pairs. These key-value pairs become environment variables accessible to your application code at runtime.  This is the primary way to configure your application without modifying the code itself.

**Example:**

```terraform
app_settings = {
  "WEBSITE_RUN_FROM_PACKAGE" = "1"  # Recommended for deployment
  "DATABASE_CONNECTION_STRING" = "your_connection_string" # Use Key Vault for production!
  "API_KEY" = "your_api_key"  # Use Key Vault for production!
  "FEATURE_FLAG_NEW_UI" = "true"
}

### `site_config`

site_config = {
  always_on                       = true # Keep the app always running
  ftps_state                      = "Disabled" # Disable FTP for security
  app_scale_limit                 = 5 # Limit scaling to 5 instances
  runtime_scale_monitoring_enabled = true
  application_stack { # For .NET, Node.js, Python, Java
    dotnet_version = "v6.0" # Example .NET version
    node_version = "16.x" # Example Node.js version
    python_version = "3.9" # Example Python version
    java_version = "17" # Example Java version
    java_container = "TOMCAT" # Example Java container
    java_container_version = "9.0" # Example Java container version
  }
  linux_fx_version = "DOCKER|your-docker-image:tag" # For Linux Docker images
  windows_fx_version = "DOCKER|[mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2022](https://www.google.com/search?q=https://mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2022)" # For Windows Docker images
  managed_pipeline_mode = "Integrated" # For Windows, "Integrated" or "Classic"
  # ... other site configuration options
}

```

** Outputs: **

| Name | Description | Type |
|------|-------------|------|
| `id` | The ID of the App Service. | `string` |
| `name` | The name of the App Service. | `string` |
| `default_site_hostname` | The default site hostname of the App Service. | `string` |
| `hostnames` | List of hostnames for the App Service. | `list(string)` |
| `identity` | The identity block of the App Service. | `object` |
