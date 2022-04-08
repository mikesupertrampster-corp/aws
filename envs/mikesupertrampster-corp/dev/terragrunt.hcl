include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules//account_setup"
}

inputs = {
  account_alias  = "mikesupertrampster-dev"
  account_id     = 639369124033
  tags           = { Environment = "dev", Managed_By = "Terraform" }
}
