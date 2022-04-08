include {
  path = find_in_parent_folders()
}

inputs = {
  organisation_units = ["dev", "prd"]
  region             = "eu-west-1"
  tags               = {}
  auth0_domain       = "mikesupertrampster-eu.eu.auth0.com"
  aws_acs_id         = "284d0fdc-de8b-4fc3-b5c8-a96a19f216ad"
}