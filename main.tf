terraform {
  cloud {
    organization = "Exam-Project-SWD"

    workspaces {
      name = "test"
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

variable "admin_user" {
  type = string
}

variable "admin_password" {
  type = string
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "mtogo"
  location = "West Europe"
}

resource "azurerm_mysql_flexible_server" "db-server" {
  name                   = "mtogo-db-server"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  sku_name               = "B_Standard_B1s"
  administrator_login    = var.admin_user
  administrator_password = var.admin_password
  version                = "8.0.21"

  lifecycle {
    ignore_changes = [
      zone
    ]
  }
}

resource "azurerm_mysql_flexible_database" "db" {
  name                = "mtogo-db"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_flexible_server.db-server.name
  charset             = "utf8"
  collation           = "utf8_general_ci"
}
