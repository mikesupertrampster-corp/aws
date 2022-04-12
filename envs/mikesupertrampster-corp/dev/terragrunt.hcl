include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules//account"
}

inputs = {
  account_alias  = "mikesupertrampster-dev"
  account_id     = 639369124033
  keypair        = "cardno:9"
  environment    = "dev"
  tags           = { Environment = "dev", Managed_By = "Terraform" }
}
