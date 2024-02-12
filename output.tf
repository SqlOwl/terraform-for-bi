output "resource_group_name" {
  description = "Created Resource Group Name"
  value       = azurerm_resource_group.rg.name
}

output "azurerm_data_factory_name" {
  description = "Created ADF Name"
  value       = module.adf.azurerm_data_factory_name
}

output "azure_sql_db_name" {
  description = "Created DB Name"
  value = azurerm_mssql_database.sql_db.name
}