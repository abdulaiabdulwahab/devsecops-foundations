terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "admin_cidr" {
  description = "Trusted administrator IP range"
  type        = string
}

resource "azurerm_resource_group" "lab" {
  name     = "rg-devsecops-lab"
  location = "canadacentral"
}

resource "azurerm_network_security_group" "lab" {
  name                = "nsg-devsecops-lab"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"

    source_port_range          = "*"
    source_address_prefix      = var.admin_cidr

    destination_port_range     = "22"
    destination_address_prefix = "*"
  }
}