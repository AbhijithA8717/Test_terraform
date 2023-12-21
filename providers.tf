terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  client_id       = "a47e8334-a2eb-4bbe-b9ef-65bef6456134"
  client_secret   = "IW18Q~N5opERwYp.9Reybsq41Yfyue5rOm4kfaA2"
  tenant_id       = "cea297cb-9bde-428d-9a6e-48fa9c582ed6"
  subscription_id = "0188d90b-c80f-4b33-bcf8-22bdab962005"
}