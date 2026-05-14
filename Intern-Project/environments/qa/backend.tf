terraform {
  backend "azurerm" {
    resource_group_name  = "rg-aedp-shared-inc-001"
    storage_account_name = "staedptfstateinc001"
    container_name       = "tfstate"
    key                  = "qa.terraform.tfstate"

    # Uses Azure CLI authentication (az login)
    use_azuread_auth = true
  }
}