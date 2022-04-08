terraform {
  required_providers {
    auth0 = {
      source = "auth0/auth0"
    }
  }
}

variable "auth0_domain" {
  type    = string
}

variable "aws_acs_id" {
  type = string
}

provider "auth0" {
  domain = var.auth0_domain
}

data "aws_ssoadmin_instances" "sso" {}

locals {
  aws_sso_acs_url   = "https://${data.aws_ssoadmin_instances.sso.id}.signin.aws.amazon.com/platform/saml/acs/${var.aws_acs_id}"
  schema_claims_url = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims"
}

resource "auth0_client" "aws" {
  name      = "AWS SSO"
  app_type  = "spa"
  callbacks = [local.aws_sso_acs_url]
  logo_uri  = "https://symbols.getvecta.com/stencil_73/94_amazon-web-services-icon.8cfc0dbbf2.svg"

  addons {
    samlp {
      audience  = "https://${data.aws_ssoadmin_instances.sso.id}.signin.aws.amazon.com/platform/saml/${tolist(data.aws_ssoadmin_instances.sso.identity_store_ids)[0]}"
      recipient = local.aws_sso_acs_url

      mappings = {
        email = "${local.schema_claims_url}/emailaddress"
        name  = "${local.schema_claims_url}/name"
      }

      create_upn_claim                   = false
      passthrough_claims_with_no_mapping = false
      map_unknown_claims_as_is           = false
      map_identities                     = false
      name_identifier_format             = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
      name_identifier_probes             = ["${local.schema_claims_url}/emailaddress"]
    }
  }
}

output "idp_sign_in_url" {
  value = "https://${var.auth0_domain}/samlp/${auth0_client.aws.id}"
}

output "idp_issuer_url" {
  value = var.auth0_domain
}

data "auth0_client" "aws" {
  name = auth0_client.aws.name
}

output "idp_cert" {
  value = data.auth0_client.aws.signing_keys[0].cert
}

#------------------------------------------------------------------------------
# Manual Configuration
# ====================
#
# Goto https://<region>.console.aws.amazon.com/singlesignon/identity/home
# Switch to External identity provider
# Set "IdP sign-in URL"
# Set "IdP issuer URL"
# Set "IdP certificate"
#------------------------------------------------------------------------------

resource "aws_ssoadmin_permission_set" "read_only" {
  name         = "AWSReadOnlyAccess"
  instance_arn = tolist(data.aws_ssoadmin_instances.sso.arns)[0]
}

data "aws_iam_policy" "read_only" {
  name = "SecurityAudit"
}

resource "aws_ssoadmin_managed_policy_attachment" "read_only" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.sso.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.read_only.arn
  managed_policy_arn = data.aws_iam_policy.read_only.arn
}

#------------------------------------------------------------------------------
# Manual Configuration
# ====================
#
# Create AWS SSO user
# Create AWS SSO group and assign user to group
# Assign AWS SSO group to AWS accounts
# Assign AWSReadOnlyAccess permission set
#------------------------------------------------------------------------------