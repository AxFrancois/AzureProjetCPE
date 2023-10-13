terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.75.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.43.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "AxFrancois_CPE"
    storage_account_name = "tfstate909487376"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "77bb0b07-57e5-44b5-a350-310a93917298"
  features {}
  skip_provider_registration = true
}

provider "azuread" {
  tenant_id = "ce4775d3-1c2e-4644-b2bc-631c157d2be7"
}

resource "azurerm_resource_group" "RG_CPE" {
  name     = "CPE-POC"
  location = var.region
}