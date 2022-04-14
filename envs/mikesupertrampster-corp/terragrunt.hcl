generate "backend" {
  path      = "config.tf"
  if_exists = "overwrite_terragrunt"
  contents  = templatefile("../../_files/template/config.tf", {
    organization = basename(get_parent_terragrunt_dir())
    workspace_name = "terraform-aws-${replace(path_relative_to_include(), "/(\\.|/)/", "-")}"
  })
}

inputs = {
  region         = "eu-west-1"
  bootstrap_role = "TerraformAdminRole"
  tags           = { Managed_By = "Terraform" }
}