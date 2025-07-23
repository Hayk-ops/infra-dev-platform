azure_group_config = {
  name     = "rg-hayk-dev",
  location = "eastus"
  tags = {
    environment = "Dev"
  }
}

azure_sub_id = "06bfd039-87c6-4548-957a-4416d2fe0e53"

azure_vnet_config = {
  name          = "dev_rg_hayk_network"
  address_space = ["10.0.0.0/16"]
}

azure_publicip_config = {
  name              = "dev_rg_pip"
  allocation_method = "Static"
}

azure_subnet_config = {
  name             = "dev_rg_subnet"
  address_prefixes = ["10.0.2.0/24"]
}

azure_ni_config = {
  name = "dev_rg_ni"
  ip_configuration = {
    name                          = "testconfig-ip"
    private_ip_address_allocation = "Dynamic"
  }
}

azure_vm_config = {
  name                            = "dev-rg-vm"
  size                            = "Standard_B1s"
  admin_username                  = "adminuser"
  disable_password_authentication = true

  admin_ssh_key = {
    username   = "adminuser"
    public_key = ""
  }

  network_interface_ids = []

  source_image_reference = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk = {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}

azurerm_network_security_rule = [
  {
    name                       = "dev_rg_nsgrule"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "allow-http"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]

application_security_group_name = "dev_rg_appsg"
network_security_group_name     = "dev_rg_nsg"

storage_account_config = {
  name                            = "devhaykstorageacct"
  account_tier                    = "Standard"
  account_kind                    = "StorageV2"
  account_replication_type        = "LRS"
  https_traffic_only_enabled      = true
  access_tier                     = "Hot"
  allow_nested_items_to_be_public = true
}

azurerm_storage_container_config = {
  name                  = "tfstate"
  container_access_type = "private"
}

# AZURE VAULT
key_vault_dev_core_config = {
  name     = "hayk-dev-key-vault"
  sku_name = "standard"
}

certificate_permissions = [
  "Get",
  "Import"
]

web_app_resource_provider_config = {
  secret_permissions = [
    "Get"
  ]

  certificate_permissions = [
    "Get"
  ]
}

azurerm_svc_cert_config = {
  name = "hayk-dev-cert"
}

microsoft_web_object_id    = "abfa0a7c-a6b6-4736-8310-5855508787cd"
azurerm_svc_cert_secret_id = "https://hayk-dev-key-vault.vault.azure.net/secrets/hayk-dev-cert/d70b7202eb0544bb94f68601868a9158"

secret_permissions_current_user = [
  "Get",
  "List",
  "Set",
  "Delete"
]

certificate_permissions_current_user = [
  "Get",
  "List",
  "Import",
  "Delete"
]
