variable "environment" {
  type = string
  default = "dev"
}

variable "eventhub_authorization_rule_id" {
  type        = string
  description = "The Event Hub authorization rule ID for diagnostic settings."
  default     = "/subscriptions/56bdaed4-70cf-4a28-8fb8-0efc135bb29f/resourceGroups/LOGS_RG/providers/Microsoft.EventHub/namespaces/evh-sharedsvcseastus/authorizationRules/RootManageSharedAccessKey"
}

variable "eventhub_name" {
  type        = string
  description = "The Event Hub name for diagnostic settings."
  default     = "cs-resource_resourcelogs"
}

variable "location" {
  type = string
  default = "eastus"
}

variable "managed_vnet_enabled" {
  type = bool
  default = true
}

variable "private_endpoint_dns_zone_ids" {
  type = list(string)
  default = [ "/subscriptions/56bdaed4-70cf-4a28-8fb8-0efc135bb29f/resourceGroups/rg-azuredns-prd-01/providers/Microsoft.Network/privateDnsZones/privatelink.datafactory.azure.net" ]
}

variable "private_endpoint_dns_zone_group_name" {
  type = string
  default = "default"
}

variable "private_endpoint_subnet_id" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "solution_name" {
  type = string
}

variable "tags" {
  type = map(string)  
}
