terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.70.0"
    }
  }
}
# Configure the Microsoft Azure Provider
provider "azurerm" {
   features {}
   subscription_id = "d6fed157-88c7-40e2-a608-46c341ba57d4"
   client_id = "4bb0cd57-01f5-47fc-affe-8e0465cc5eaf"
   client_secret = "6c2ac435-c772-42d5-a03b-ab0e7a743a63" 
   tenant_id = "d7c42f03-ba1c-4e4f-ade6-daf999509bec"
}
resource "azurerm_resource_group" "name" {
  name = "store_rg"
  location = "CentralUS"
}
# creating Azure Container Registry
resource "azurerm_container_registry" "name" {
  name="datacontainer595"
  location = azurerm_resource_group.name.location
  resource_group_name = azurerm_resource_group.name.name
  sku = "Standard"
}
# creating Azure Container App
resource "azurerm_container_app_environment" "name" {
  name = "env-data-container"
 resource_group_name = azurerm_resource_group.name.name
  location = azurerm_resource_group.name.location
}

resource "azurerm_container_app" "name" {
  name = "datacontainerapp595"
  resource_group_name = azurerm_resource_group.name.name
  revision_mode = "Single"
  container_app_environment_id = azurerm_container_app_environment.name.id
  template {
    
    container {
       name = "appcontainer123"
       image = "nginx"
      memory = "0.5Gi"
      cpu = "0.25"
  }
  }
}
# creating Azure Kubernet Service
resource "azurerm_kubernetes_cluster" "name" {
  name = "datakubernets"
  location = azurerm_resource_group.name.location
  resource_group_name = azurerm_resource_group.name.name
  dns_prefix = "exampleaks1"
  identity {
    type = "SystemAssigned"
  }
  default_node_pool {
    name = "default"
    node_count = 1
    vm_size = "standard_a2_v2"
  }
}
# Creating Azure Stream analytics - taking around 1hr to deploy
# resource "azurerm_stream_analytics_cluster" "name" {
#   name = "datastreamanalytics"
#   location = azurerm_resource_group.name.location
#   resource_group_name = azurerm_resource_group.name.name
#   streaming_capacity = 36
# }

  
  
  
  
