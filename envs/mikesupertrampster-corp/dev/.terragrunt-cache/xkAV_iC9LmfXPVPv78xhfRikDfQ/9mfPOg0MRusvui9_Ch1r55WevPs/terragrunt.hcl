include {
  path = find_in_parent_folders()
}

terraform {
  source = "../modules/account_setup"
}

inputs = {
  region = "eu-west-1"
}
