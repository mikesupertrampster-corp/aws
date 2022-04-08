include {
  path = find_in_parent_folders()
}

terraform {
  source = "../modules//account_setup"
}

inputs = {
  account_alias  = "mikesupertrampster-dev"
  account_id     = 639369124033
  bootstrap_role = "TerraformAdminRole"
  region         = "eu-west-1"
  tags           = { Environment = "dev", Managed_By = "Terraform" }
}
