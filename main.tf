 provider "azurerm" {
  storage_use_azuread = true
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-bi001-${var.env_name}"
  location = var.azure_region
  tags     = var.tags

  lifecycle {
    ignore_changes = [tags]
  }
}

module "adf" {
  source = "./modules/adf"
  adf_resource_group_name = azurerm_resource_group.rg.name
  adf_environment_name = var.env_name
  adf_azure_region = azurerm_resource_group.rg.location
  adf_tags = var.tags

  depends_on = [
    azurerm_resource_group.rg
  ]
}


resource "azurerm_storage_account" "storage_account" {
  name                            = "sabi001${var.env_name}"
  min_tls_version                 = "TLS1_2"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  is_hns_enabled                  = true
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = true
  tags                            = var.tags

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [tags]
  }

  depends_on = [azurerm_resource_group.rg]
}

resource "azurerm_mssql_server" "sql_server_instance" {
  name                = "sqlsrvbi001${var.env_name}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  version             = "12.0"
  tags                = var.tags

  azuread_administrator {
    login_username              = "sqladmin"
    object_id                   = var.azure_sqlsrv_admin_id
    azuread_authentication_only = true
  }

  depends_on = [azurerm_resource_group.rg]

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_mssql_database" "sql_db" {
  name         = "bi001_${var.env_name}"
  server_id    = azurerm_mssql_server.sql_server_instance.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 5
  sku_name     = var.database_size

  tags = var.tags

    depends_on = [azurerm_resource_group.rg,azurerm_mssql_server.sql_server_instance]


  lifecycle {
    ignore_changes = [tags]
  }
}