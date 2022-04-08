include {
  path = find_in_parent_folders()
}

inputs = {
  auth0_domain                = "mikesupertrampster-eu.eu.auth0.com"
  aws_acs_id                  = "284d0fdc-de8b-4fc3-b5c8-a96a19f216ad"
  organisation_email_pattern  = "mikesupertrampster+%s@gmail.com"
  tags                        = { Environment = "root", Managed_By = "Terraform" }

  organisation_units = ["dev", "prd"]
  accounts           = {
                          dev = {
                            organisation_unit = "dev"
                          }
                        }
}