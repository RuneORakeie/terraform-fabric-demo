module "ws_conn_eventhub" {
  source          = "github.com/RuneORakeie/terraform-modules-fabric//fabric-connection?ref=v0.1.3"
  connection_name = "AzEventHub-${var.solution_name}"
  connection_type = "EventHub"

  connectivity_type = "ShareableCloud"
  privacy_level     = "None" # Optional, defaults to "Organizational"

  eventhub_parameters = {
    namespace = var.azeventhub_namespace
    name      = var.azeventhub_name
  }

  eventhub_credentials = {
    shared_access_key_name = "Fabric"
    shared_access_key      = var.azeventhub_saskey
  }

  # Optional: Add role assignments
  connection_role_assignments = [
    {
      principal_id   = data.azuread_group.fabric_ws_contributors.object_id
      principal_type = "Group"
      role           = "Owner"
    },
    {
      principal_id   = data.azuread_user.admin.object_id
      principal_type = "User"
      role           = "Owner"
    },

  ]
}
