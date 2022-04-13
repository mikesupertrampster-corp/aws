provider "aws" {
  alias  = "root"
  region = var.region
}

provider "aws" {
  region = var.region

  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/${var.bootstrap_role}"
  }

  default_tags {
    tags = var.tags
  }
}