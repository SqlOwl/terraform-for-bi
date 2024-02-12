
resource "azurerm_data_factory" "adf" {
  name                            = "adf-bi001-${var.adf_environment_name}"
  location                        = var.adf_azure_region
  resource_group_name             = var.adf_resource_group_name
  tags                            = var.adf_tags

  lifecycle {
    ignore_changes = [tags]
  }

}

resource "azurerm_data_factory_pipeline" "pipeline_1" {
  name            = "pipeline_1"
  data_factory_id = azurerm_data_factory.adf.id

  depends_on = [ azurerm_data_factory.adf ]
}