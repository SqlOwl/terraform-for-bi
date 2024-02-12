variable "env_name" {
    type    = string
    description = "Name of Environment, dev, test, qa, prod"
    default = "dev"
}
variable "azure_region" {
    type = string
    description = "Standard name of Azure Region"
    default = "norwayeast"
}
variable "database_size" {
    type = string
    description = "Database SKU Name"
    default = "S0"
}
variable "tags" {
  type = map(string)
  description = "list of tags that are assigned to each resource"
  default = {
        DeployedBy = "Terraform"
        Owner = "Owner Name"
  }
}
variable "azure_sqlsrv_admin_id" {
    type = string
    description = "Object_Id of user/group that will be assigned admin priviliges over Azure SQL Server"
    default = ""  
}