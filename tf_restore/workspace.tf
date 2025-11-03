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


# resource "fabric_workspace_managed_private_endpoint" "azeventhub" {
#   workspace_id                    = module.demo_ws_prod.id
#   name                            = "mpe-azeventhub-demo"
#   target_private_link_resource_id = data.azurerm_eventhub_namespace.demo.id
#   target_subresource_type         = "namespace"
#   request_message                 = "Request message to approve private endpoint"
# }

# data "azurerm_eventhub_namespace" "demo" {
#   name                = "raspberrypi-sim-weu"
#   resource_group_name = "pcs-d-rg-rasberrypi-sim"
#   provider            = azurerm.vs-studio
# }
