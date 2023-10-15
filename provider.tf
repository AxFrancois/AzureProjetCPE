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
    use_oidc             = true
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = var.subscription_id
  skip_provider_registration = true
  use_oidc                   = true
  features {}
}

provider "azuread" {
  tenant_id = var.tenant_id
}

resource "azurerm_resource_group" "RG_CPE" {
  name     = "CPE-POC"
  location = var.region
}