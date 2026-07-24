terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# 1. Группа ресурсов Azure
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# 2. Azure Container Instance (ACI)
resource "azurerm_container_group" "aci" {
  name                = var.container_group_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "Public"
  dns_name_label      = var.dns_name_label
  os_type             = "Linux"

  # Учетные данные для доступа к GHCR
  image_registry_credential {
    server   = "ghcr.io"
    username = var.ghcr_username
    password = var.ghcr_pat_token
  }

  # Описание контейнера
  container {
    name   = var.container_name
    image  = var.container_image
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = var.container_port
      protocol = "TCP"
    }

    # Переменные окружения (при необходимости)
    environment_variables = {
      "PORT" = tostring(var.container_port)
    }
  }
}
