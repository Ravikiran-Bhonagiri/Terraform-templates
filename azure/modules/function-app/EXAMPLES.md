# Azure Function App Module

This Terraform module deploys an Azure Function App. It allows customization of various aspects of the Function App, including the name, resource group, storage account connection, and function app settings.  See the full documentation for input variables and outputs.

## Examples of Different Function App Deployments using the Module

This section provides examples of how to use the Azure Function App module to deploy different types of function apps.

### Example 1: HTTP Trigger Function App (Python)

```terraform
module "http_function_app" {
  source = "path/to/module/azure/modules/function-app"

  name                = "my-http-function-app"
  resource_group_name = "rg-my-resources"
  location            = "West US 2"
  storage_account_connection_string = "Endpoint=[https://mystorage.blob.core.windows.net/;AccountName=mystorage;AccountKey=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx](https://www.google.com/search?q=https://mystorage.blob.core.windows.net/%3BAccountName%3Dmystorage%3BAccountKey%3Dxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx)"

  app_settings = {
    "AzureWebJobsStorage" = "Endpoint=[https://mystorage.blob.core.windows.net/;AccountName=mystorage;AccountKey=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx](https://www.google.com/search?q=https://mystorage.blob.core.windows.net/%3BAccountName%3Dmystorage%3BAccountKey%3Dxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx)"
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
    "FUNCTIONS_WORKER_RUNTIME" = "python"
  }

  site_config = {
    always_on = true
  }
}```

This example deploys a Python function app that's triggered by HTTP requests. This means the function will execute when it receives an HTTP request (like a GET, POST, etc.).

source: This line specifies the location of the Function App module. Replace "path/to/module/azure/modules/function-app" with the actual path to the module in your Terraform project.
name: This sets the name of your Function App in Azure. Choose a unique name within your resource group.
resource_group_name: This defines the resource group where the Function App will be created. Make sure this resource group exists beforehand.
location: Specifies the Azure region where the Function App will be deployed.
storage_account_connection_string: This provides the connection string for the Azure Storage account that the Function App will use. This is essential for storing function code, logs, and other data. Replace the placeholder connection string with your actual storage account connection string.
app_settings: This block configures application settings for the Function App.
"AzureWebJobsStorage": Again, the storage account connection string. It's often good practice to separate this and re-use the same variable for both.
"WEBSITE_RUN_FROM_PACKAGE": This setting is crucial when deploying your function code as a zip package. It tells Azure to run the function from the deployed package.
"FUNCTIONS_WORKER_RUNTIME": This tells Azure that the function app is written in Python. This is how Azure knows which runtime environment to use.
site_config: This setting keeps the Function App "always on," preventing it from going idle. This is often recommended, especially for HTTP-triggered functions.
Deployment: After defining this Terraform configuration, you'd typically deploy your Python function code as a zip package to the Function App. The WEBSITE_RUN_FROM_PACKAGE = "1" setting makes this deployment method work. You'll also need to ensure your function code includes the necessary dependencies and is structured correctly for Azure Functions.

### Example 2: Timer Trigger Function App (C#)

```terraform
module "timer_function_app" {
  source = "path/to/module/azure/modules/function-app"

  name                = "my-timer-function-app"
  resource_group_name = "rg-my-resources"
  location            = "West US 2"
  storage_account_connection_string = "Endpoint=[https://mystorage.blob.core.windows.net/;AccountName=mystorage;AccountKey=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx](https://www.google.com/search?q=https://mystorage.blob.core.windows.net/%3BAccountName%3Dmystorage%3BAccountKey%3Dxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx)"

  app_settings = {
    "AzureWebJobsStorage" = "Endpoint=[https://mystorage.blob.core.windows.net/;AccountName=mystorage;AccountKey=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx](https://www.google.com/search?q=https://mystorage.blob.core.windows.net/%3BAccountName%3Dmystorage%3BAccountKey%3Dxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx)"
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
    "FUNCTIONS_WORKER_RUNTIME" = ".net"
    "MyTimerSchedule" = "0 */5 * * *"
  }

  site_config = {
    always_on = true
  }
}
```

This example sets up a C# Function App that's triggered on a schedule using a timer trigger.

Most of the settings (name, resource group, location, storage connection string) are the same as the Python example. Refer to Example 1 for details on these common settings.
"FUNCTIONS_WORKER_RUNTIME" = ".net": This line sets the runtime to .net, indicating that this is a C# function app. You could also use .net-isolated for the .NET isolated process. The isolated process is generally recommended for newer .NET functions.
"MyTimerSchedule" = "0 */5 * * *": This is the timer trigger configuration. It's a CRON expression that defines the schedule. 0 */5 * * * means the function will run every 5 minutes. You can adjust this CRON expression to your desired schedule. CRON expressions are powerful and allow for very complex schedules. Consult CRON expression documentation for details on the syntax.
Deployment: You'll compile your C# function code (creating a DLL) and deploy it as a zip package, similar to the Python example. The MyTimerSchedule app setting is how the timer trigger is configured. Azure will automatically run the function according to this schedule.


### Example 3: Consumption Plan Function App with Managed Identity (Node.js)

```terraform
module "consumption_function_app" {
  source = "path/to/module/azure/modules/function-app"

  name                = "my-consumption-function-app"
  resource_group_name = "rg-my-resources"
  location            = "West US 2"
  storage_account_connection_string = "Endpoint=[https://mystorage.blob.core.windows.net/;AccountName=mystorage;AccountKey=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx](https://www.google.com/search?q=https://mystorage.blob.core.windows.net/%3BAccountName%3Dmystorage%3BAccountKey%3Dxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx)"

  identity = {
    type = "SystemAssigned"
  }

  app_settings = {
    "AzureWebJobsStorage" = "Endpoint=[https://mystorage.blob.core.windows.net/;AccountName=mystorage;AccountKey=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx](https://www.google.com/search?q=https://mystorage.blob.core.windows.net/%3BAccountName%3Dmystorage%3BAccountKey%3Dxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx)"
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
    "FUNCTIONS_WORKER_RUNTIME" = "node"
  }
}
```

This example shows how to deploy a Function App using the Consumption plan (serverless) and how to enable a system-assigned managed identity.

Key difference: We omit the app_service_plan_id, app_service_plan_name, and sku variables. By doing this, Terraform will automatically create a Function App in the Consumption plan. The Consumption plan is serverless and scales automatically based on demand. You only pay for the compute time you consume.
identity = { type = "SystemAssigned" }: This block enables a system-assigned managed identity for the Function App. Managed identities allow your Function App to access other Azure resources securely without needing to manage credentials (like API keys or connection strings) directly in your code. SystemAssigned means Azure automatically creates and manages the identity for you. It's tied to the lifecycle of the Function App itself.
"FUNCTIONS_WORKER_RUNTIME" = "node": This sets the runtime to Node.js. You can choose other runtimes (like Python, .NET, Java, etc.) as needed.
Deployment: You would deploy your Node.js function code as a zip package. The managed identity can then be used within your function code to authenticate to other Azure services.  Azure provides mechanisms (like environment variables) for your code to access the managed identity and use it to obtain access tokens for other Azure resources.  This simplifies security and eliminates the need to hardcode credentials.


### Example 4: User Assigned Managed Identity

```terraform
module "user_assigned_mi_function_app" {
  source = "path/to/module/azure/modules/function-app"

  name                = "my-user-assigned-mi-function-app"
  resource_group_name = "rg-my-resources"
  location            = "West US 2"
  storage_account_connection_string = "Endpoint=[https://mystorage.blob.core.windows.net/;AccountName=mystorage;AccountKey=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx](https://www.google.com/search?q=https://mystorage.blob.core.windows.net/%3BAccountName%3Dmystorage%3BAccountKey%3Dxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx)"

  identity = {
    type        = "UserAssigned"
    identity_ids = [
      "/subscriptions/YOUR_SUBSCRIPTION_ID/resourceGroups/YOUR_RESOURCE_GROUP/providers/Microsoft.ManagedIdentity/userAssignedIdentities/YOUR_USER_ASSIGNED_IDENTITY_NAME",
    ]
  }

  app_settings = {
    "AzureWebJobsStorage" = "Endpoint=[https://mystorage.blob.core.windows.net/;AccountName=mystorage;AccountKey=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx](https://www.google.com/search?q=https://mystorage.blob.core.windows.net/%3BAccountName%3Dmystorage%3BAccountKey%3Dxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx)"
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
    "FUNCTIONS_WORKER_RUNTIME" = "node" # Or your preferred runtime
  }
}
```

This example demonstrates how to configure a user-assigned managed identity for your Function App.

identity = { type = "UserAssigned", identity_ids = [...] }: This block configures a user-assigned managed identity. Unlike system-assigned identities (where Azure creates and manages the identity), with user-assigned identities, you create the identity beforehand. This gives you more control over the identity's lifecycle and permissions. The identity_ids list contains the Azure Resource IDs of your user-assigned managed identity (or identities, as you can assign multiple). Replace the placeholder [...] with the actual ID (or IDs) of your user-assigned managed identity resource(s). You'll find this ID in the Azure portal for your user-assigned managed identity.
Key takeaway for all examples:

Replace placeholders: Remember to replace all placeholder values (paths, connection strings, subscription IDs, resource group names, user-assigned identity names, etc.) with your actual values. These placeholders are there to show you the structure; they won't work as-is.
WEBSITE_RUN_FROM_PACKAGE = "1": This setting is extremely important for deploying your function code as a zip file. It's the recommended way to deploy functions.
FUNCTIONS_WORKER_RUNTIME: Choose the correct FUNCTIONS_WORKER_RUNTIME setting according to the programming language of your function app (e.g., "python", ".net", "node", "java").
Consumption Plan: For Consumption plan deployments (serverless), simply omit the app_service_plan_id, app_service_plan_name, and sku configurations. Terraform will then automatically deploy your function app to the Consumption plan.
