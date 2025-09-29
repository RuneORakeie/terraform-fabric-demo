# Create a Fabric Capacity.
resource "azurerm_fabric_capacity" "kql_demo" {
  name                = "fc${var.solution_name}"
  resource_group_name = data.azurerm_resource_group.fc_cap_rg.name
  location            = data.azurerm_resource_group.fc_cap_rg.location

  administration_members = [
    data.azuread_user.admin.user_principal_name,
    data.azuread_service_principal.tf_sp.object_id

  ]
  sku {
    name = var.fabric_capacity_sku
    tier = "Fabric"
  }
}
