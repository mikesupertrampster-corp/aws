module "kubernetes" {
  source             = "../kubernetes"
  environment        = var.environment
  flux_git_owner     = var.flux_git_owner
  flux_git_repo      = var.flux_git_repo
  flux_git_url       = var.flux_git_url
  keypair            = var.keypair
  private_subnet_ids = module.vpc.private_subnets
  public_subnet_ids  = module.vpc.public_subnets
  vpc_id             = module.vpc.vpc_id
}

module "kubernetes_destroy" {
  source = "../lambdas"
  name   = "eksDestroy"

  variables = {
    REGION       = data.aws_region.current.name
    CLUSTER_NAME = var.environment
  }
}

data "aws_iam_policy_document" "kubernetes_destroy" {
  statement {
    actions   = ["eks:DeleteCluster"]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "kubernetes_destroy" {
  role   = module.kubernetes_destroy.role_name
  policy = data.aws_iam_policy_document.kubernetes_destroy.json
}