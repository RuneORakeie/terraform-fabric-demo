########################
###  KQL EVENTHOUSE  ###
########################
resource "fabric_eventhouse" "kql_demo" {
  display_name = "eh-${var.solution_name}"
  workspace_id = module.demo_ws_prod.id
}

########################
###   KQL DATABASE   ###
########################
resource "fabric_kql_database" "kql_demo_db_1" {
  display_name = "kql-db-01-${var.solution_name}"
  workspace_id = module.demo_ws_prod.id
  format       = "Default"
  definition = {
    "DatabaseProperties.json" = {
      source = "../item-templates/DatabaseProperties_01.json"
      tokens = {
        "KqlEhId" = fabric_eventhouse.kql_demo.id
      }
    }
    "DatabaseSchema.kql" = {
      source = "../item-templates/DatabaseSchema_01.kql"
    }
  }
  depends_on = [fabric_eventhouse.kql_demo]

}

########################
### KQL EVENTSTREAM  ###
########################
resource "fabric_eventstream" "kql_demo_es" {
  display_name = "kql-es-${var.solution_name}3"
  workspace_id = module.demo_ws_prod.id
  format       = "Default"
  definition = {
    "eventstream.json" = {
      source = "../item-templates/eventstream_tmpl.json"
      tokens = {
        "ConnId"    = module.ws_conn_eventhub.id
        "KqlDbName" = fabric_kql_database.kql_demo_db_1.display_name
        "KqlDbId"   = fabric_kql_database.kql_demo_db_1.id
        "WsId"      = module.demo_ws_prod.id
      }
    }
    # "eventstreamProperties.json" = {
    #   source = "../item-templates/eventstreamProperties.json"
    #   tokens = {
    #   }
    # }
  }
  depends_on = [module.ws_conn_eventhub, fabric_kql_database.kql_demo_db_1]
}
# resource "restapi_object" "kql_demo_es" {
#   path = "/workspaces/${module.demo_ws_prod.id}/eventstreams"

#   data = jsonencode({
#     "displayName" : "kql-es-${var.solution_name}3",
#     "definition" : {
#       "format" : "eventstream",
#       "parts" : [
#         {
#           "path" : "eventstream.json",
#           "payload" : filebase64("../item-templates/eventstream_tmpl_values.json"),
#           "payloadType" : "InlineBase64"
#         }
#       ]
#     }
#   })

#   read_path     = "/workspaces/${module.demo_ws_prod.id}/eventstreams/{id}"
#   update_path   = "/workspaces/${module.demo_ws_prod.id}/eventstreams/{id}"
#   update_method = "PATCH"
#   destroy_path  = "/workspaces/${module.demo_ws_prod.id}/eventstreams/{id}"

#   debug = true # Enable for troubleshooting

#   depends_on = [module.ws_conn_eventhub, fabric_kql_database.kql_demo_db_1]
# }

########################
###   KQL DASHBOARD  ###
########################
resource "fabric_kql_dashboard" "kql_demo_dash" {
  display_name = "kql-dash-${var.solution_name}"
  #description  = "kql-dash-${var.solution_name}"
  workspace_id = module.demo_ws_prod.id
  format       = "Default"
  definition = {
    "RealTimeDashboard.json" = {
      source = "../item-templates/RealTimeDashboard.json"
      tokens = {
        "QuerySvcUri" = fabric_kql_database.kql_demo_db_1.properties.query_service_uri
        "KqlDbId"     = fabric_kql_database.kql_demo_db_1.id
        "WsId"        = module.demo_ws_prod.id
        "ImgURL"      = "![markdown](https://datarune.online/img/PASS2025-Logo-Dark-Date.png)"
      }
    }
  }
  depends_on = [fabric_kql_database.kql_demo_db_1]
}
