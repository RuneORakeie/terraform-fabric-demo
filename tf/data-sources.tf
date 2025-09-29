#######################
### RESOURCE GROUPS ###
#######################
data "azurerm_resource_group" "fc_cap_rg" {
  name = "datarunefabric-noe"
}
#######################
### FABRIC CAPACITY ###
#######################
data "fabric_capacity" "capacity" {
  display_name = "fc${var.solution_name}"
  depends_on   = [azurerm_fabric_capacity.kql_demo]
}
#######################
### Entra ID Group  ###
#######################
data "azuread_group" "fabric_ws_contributors" {
  display_name = "Terraform Demo - Workspace Contributors"
}
#######################
###  Entra ID User  ###
#######################
data "azuread_user" "admin" {
  user_principal_name = var.admin_user
}
###################################
### Entra ID Service Principal  ###
###################################
data "azuread_service_principal" "tf_sp" {
  display_name = "pcs-s-sp-terraform"
}
