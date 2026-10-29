terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}

resource "random_string" "suffix" {
  length = 4
  numeric = true
  lower = false
  special = false
  upper = false
}

data "azurecaf_name" "adf" {
  resource_type = "azurerm_data_factory"
  suffixes = [ var.solution_name, var.location, var.environment, random_string.suffix.result ]
}

resource "azurerm_data_factory" "adf" {
  identity {
    type = "SystemAssigned"
  }
  managed_virtual_network_enabled = var.managed_vnet_enabled
  location = var.location
  name     = data.azurecaf_name.adf.result
  public_network_enabled = false
  resource_group_name = var.resource_group_name
  tags = var.tags
}

resource "azurerm_private_endpoint" "adf_pep" {
  location = azurerm_data_factory.adf.location
  name = "pe-${azurerm_data_factory.adf.name}"
  resource_group_name = azurerm_data_factory.adf.resource_group_name
  subnet_id = var.private_endpoint_subnet_id
  private_service_connection {
    name = "pe-connection-${azurerm_data_factory.adf.name}"
    is_manual_connection = false
    private_connection_resource_id = azurerm_data_factory.adf.id
    subresource_names = ["dataFactory"]
  }
  private_dns_zone_group {
    name = var.private_endpoint_dns_zone_group_name
    private_dns_zone_ids = var.private_endpoint_dns_zone_ids
  }
  depends_on = [ azurerm_data_factory.adf ]
}

resource "azurerm_monitor_diagnostic_setting" "adf_diagnostic" {
  name = "diagsetting-${azurerm_data_factory.adf.name}"
  target_resource_id = azurerm_data_factory.adf.id
  eventhub_authorization_rule_id = var.eventhub_authorization_rule_id
  eventhub_name = var.eventhub_name
  enabled_log {
    category_group = "allLogs"
  }
  depends_on = [ azurerm_data_factory.adf ]
}
