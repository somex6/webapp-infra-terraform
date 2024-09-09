terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.0.1"
    }
  }

  cloud {
    organization = "hagital"

    workspaces {
      name = "webapp-dev"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "7ea1702d-d0c5-423b-ba9a-b69218aaf564"
}

resource "azurerm_resource_group" "taz" {
  name     = "terraformRG"
  location = "canada central"
}

module "securestorage" {
  source               = "somex6/storage-tf-module/azure"
  version              = "1.0.0"
  location             = azurerm_resource_group.taz.location
  resource_group_name  = azurerm_resource_group.taz.name
  storage_account_name = "somexstore"
  environment          = "development"
}
