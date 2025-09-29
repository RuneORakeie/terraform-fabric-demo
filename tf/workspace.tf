module "demo_ws_prod" {
  source        = "github.com/RuneORakeie/terraform-modules-fabric//fabric-workspace?ref=v0.1.3"
  display_name  = "${var.solution_name} - WS"
  description   = "Terraform for Microsoft Fabric - RTI demo workspace"
  capacity_id   = data.fabric_capacity.capacity.id
  identity_type = "SystemAssigned"
  role_assignment_list = [
    {
      principal_id   = data.azuread_group.fabric_ws_contributors.object_id
      principal_type = "Group"
      role           = "Contributor"
    },
    {
      principal_id   = data.azuread_user.admin.object_id
      principal_type = "User"
      role           = "Admin"
    },
  ]
}

