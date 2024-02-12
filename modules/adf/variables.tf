variable "adf_environment_name" {
    type    = string
}
variable "adf_azure_region" {
    type = string
}
variable "adf_tags" {
  type = map(string)
}
variable "adf_resource_group_name" {
  type = string
}