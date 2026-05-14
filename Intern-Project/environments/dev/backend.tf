terraform {
  backend "azurerm" {
    resource_group_name  = "rg-aedp-shared-inc-001"
    storage_account_name = "staedptfstateinc001"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"

    subscription_id = "b7e60d03-cfbc-480e-af93-dc72b2f0c289"

    # Uses Azure CLI authentication (az login)
    # use_azuread_auth = true
  }
}