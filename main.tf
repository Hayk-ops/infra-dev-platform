terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm",
      version = "4.34.0"
    }
  }
  backend "azurerm" {}
}

data "azurerm_key_vault" "main" {
  name                = "hayk-dev-key-vault"
  resource_group_name = "rg-hayk-dev"
}

data "azurerm_key_vault_secret" "web_app_client_id" {
  name         = "web-app-client-id"
  key_vault_id = data.azurerm_key_vault.main.id
}

data "azurerm_key_vault_secret" "github_oidc_secrets_officer" {
  name         = "github-oidc-secrets-officer"
  key_vault_id = data.azurerm_key_vault.main.id
}

data "azurerm_key_vault_secret" "ssh_public_key" {
  name         = "ssh-public-key"
  key_vault_id = data.azurerm_key_vault.main.id
}

data "azurerm_client_config" "current" {}

provider "azurerm" {
  features {}
  subscription_id = var.azure_sub_id
}

provider "azuread" {
  tenant_id = data.azurerm_client_config.current.tenant_id
}

module "resource_group_core" {
  source = "./module/core_modules/resource_group/resource_group"

  name     = var.azure_group_config.name
  location = var.azure_group_config.location
  tags     = var.azure_group_config.tags
}

module "azure_storage" {
  source = "./module/core_modules/storage_account"

  storage_account_config           = var.storage_account_config
  azurerm_storage_container_config = var.azurerm_storage_container_config
  resource_group_info              = module.resource_group_core.resource_group_info
}

module "azure_key_vault" {
  source = "./module/core_modules/azure_key_vault"

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id

  key_vault_dev_core_config = merge(
    var.key_vault_dev_core_config,
    {
      resource_group_name = module.resource_group_core.resource_group_info.name
      location            = module.resource_group_core.resource_group_info.location
    }
  )

  certificate_permissions          = var.certificate_permissions
  web_app_resource_provider_config = var.web_app_resource_provider_config

  azurerm_svc_cert_config = {
    name                = var.azurerm_svc_cert_config.name
    location            = module.resource_group_core.resource_group_info.location
    resource_group_name = module.resource_group_core.resource_group_info.name
  }

  certificate_permissions_current_user = var.certificate_permissions_current_user
  secret_permissions_current_user      = var.secret_permissions_current_user

  microsoft_web_object_id    = var.microsoft_web_object_id
  azurerm_svc_cert_secret_id = var.azurerm_svc_cert_secret_id

  github_oidc_secrets_officer_id = data.azurerm_key_vault_secret.github_oidc_secrets_officer.value

  web_app_resource_provider_client_id = data.azurerm_key_vault_secret.web_app_client_id.value
}


module "vm_stack" {
  source = "./module/vm_stack"

  resource_group_info   = module.resource_group_core.resource_group_info
  azure_vnet_config     = var.azure_vnet_config
  azure_publicip_config = var.azure_publicip_config
  azure_subnet_config   = var.azure_subnet_config
  azure_ni_config       = var.azure_ni_config
  azure_vm_config = merge(
    var.azure_vm_config,
    {
      admin_ssh_key = merge(
        try(var.azure_vm_config.admin_ssh_key, {}),
        {
          public_key = data.azurerm_key_vault_secret.ssh_public_key.value
        }
      )
    }
  )
  azurerm_network_security_rule = [
    for rule in var.azurerm_network_security_rule : merge(
      rule,
      {
        resource_group_name         = module.resource_group_core.resource_group_info.name,
        network_security_group_name = var.network_security_group_name
      }
    )
  ]
  application_security_group_name = var.application_security_group_name
  network_security_group_name     = var.network_security_group_name
}