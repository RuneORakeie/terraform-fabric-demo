#############################################
#          Azure Resource Manager           #
#############################################
provider "azurerm" {
  features {}
  client_id                       = var.client_id
  use_oidc                        = true
  resource_provider_registrations = "none"
}
#############################################
#          Azure Active Directory           #
#############################################
provider "azuread" {
  client_id = var.client_id
  use_oidc  = true
}
#############################################
#           Microsoft Fabric                #
#############################################
provider "fabric" {
  preview = true
  # use_oidc = true
}

#############################################
#       Microsoft Fabric REST API           #
#############################################
provider "restapi" {
  uri                  = "https://api.fabric.microsoft.com/v1"
  write_returns_object = true

  headers = {
    Authorization = "Bearer ${jsondecode(data.http.azure_token.response_body).access_token}"
  }
}
data "http" "azure_token" {
  # The token endpoint URL with variable interpolation
  url = "https://login.microsoftonline.com/${var.tenant_id}/oauth2/v2.0/token"
  # Specify POST method for token request
  method = "POST"
  # Set required headers for token request
  request_headers = {
    "Content-Type" = "application/x-www-form-urlencoded"
  }
  # Form-encoded body with OAuth2 parameters
  request_body = "grant_type=client_credentials&client_id=${var.client_id}&client_secret=${var.client_secret}&scope=https://api.fabric.microsoft.com/.default"
}


# locals {
#   is_github_actions = fileexists("/github/workspace")
#   gha_oidc_token    = local.is_github_actions ? coalesce(nonsensitive(sensitive(coalesce(getenv("ACTIONS_ID_TOKEN_REQUEST_TOKEN"), ""))), "") : ""
# }

# # For local development, get token using workload identity
# data "external" "azure_cli_token" {
#   count   = local.is_github_actions ? 0 : 1
#   program = ["sh", "-c", "az account get-access-token --resource-type oidc --scope https://api.fabric.microsoft.com/.default | jq -r '{token: .accessToken}'"]
# }

# provider "restapi" {
#   uri                  = "https://api.fabric.microsoft.com/v1"
#   write_returns_object = true

#   headers = {
#     Authorization = "Bearer ${jsondecode(data.http.azure_token.response_body).access_token}"
#   }
# }
# data "http" "azure_token" {
#   # The token endpoint URL with variable interpolation
#   url = "https://login.microsoftonline.com/${var.tenant_id}/oauth2/v2.0/token"

#   # Specify POST method for token request
#   method = "POST"

#   # Set required headers for token request
#   request_headers = {
#     "Content-Type" = "application/x-www-form-urlencoded"
#   }

#   # Form-encoded body with OAuth2 parameters
#   #request_body = "grant_type=client_credentials&client_id=${var.client_id}&client_secret=${var.client_secret}&scope=https://api.fabric.microsoft.com/.default"
#   request_body = local.is_github_actions ? (
#     "grant_type=client_assertion&client_id=${var.client_id}&client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer&client_assertion=${local.gha_oidc_token}&scope=https://api.fabric.microsoft.com/.default"
#     ) : (
#     "grant_type=client_assertion&client_id=${var.local_dev_client_id}&client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer&client_assertion=${data.external.azure_cli_token[0].result.token}&scope=https://api.fabric.microsoft.com/.default"
#   )
# }

# output "token" {
#   value = data.external.azure_token.result.access_token

# }

