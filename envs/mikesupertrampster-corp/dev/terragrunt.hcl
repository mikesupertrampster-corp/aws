include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules//account"
}

inputs = {
  account_alias  = "mikesupertrampster-dev"
  account_id     = 639369124033
  apex_domain    = "mikesupertrampster.com."
  environment    = "dev"
  tags           = { Environment = "dev", Managed_By = "Terraform" }
}
