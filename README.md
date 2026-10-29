# Azure Data Factory Terraform Module

## Introduction
This module deploys an Azure Data Factory instance with a private endpoint and diagnostic settings.

## Usage

```hcl
module "datafactory" {
  source = "caresource.pe.jfrog.io/shared-tfmodules-internal__data/datafactory/azurerm"
  version = "1.5.0"
  private_endpoint_subnet_id = "/subscriptions/../resourceGroups/../providers/Microsoft.Network/virtualNetworks/../subnets/.."
  solution_name = var.solution_name
  tags = var.tags
}
```

## Inputs
| Name                                | Type           | Description                                        | Default    |
|--------------------------------------|----------------|----------------------------------------------------|------------|
| private_endpoint_subnet_id           | string         | The subnet ID where the private endpoint for the data factory will be created. | n/a |
| solution_name                        | string         | The name of the solution, used in resource naming. | n/a |
| tags                                  | map(string)    | Tags to apply to the data factory resource.        | n/a |

## Outputs
| Name                                  | Description                              |
|-----------------------------------------|-------------------------------------------|
| adf                                      | The full azurerm_data_factory resource object for the created data factory. |

## Features

- Creates an Azure Data Factory with a system-assigned managed identity
- Standardizes the data factory name using the azurecaf provider naming convention
- Deploys a private endpoint for the data factory with a configurable private DNS zone group
- Configures diagnostic settings that forward all logs to an Event Hub

## Requirements

- Terraform >= 1.4.0
- AzureRM >= 3.0
