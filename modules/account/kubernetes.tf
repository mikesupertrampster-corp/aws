module "kubernetes" {
  source             = "../kubernetes"
  keypair            = var.keypair
  private_subnet_ids = module.vpc.private_subnets
  public_subnet_ids  = module.vpc.public_subnets
  vpc_id             = module.vpc.vpc_id
}

module "kubernetes_deletion" {
  source = "../lambdas"
  name   = "eksDestroy"

  variables = {
    REGION       = data.aws_region.current.name
    CLUSTER_NAME = var.environment
  }
}

data "aws_iam_policy_document" "kubernetes_deletion" {
  statement {
    actions   = ["eks:DeleteCluster"]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "kubernetes_deletion" {
  name   = "EksDestroy"
  role   = module.kubernetes_deletion.role_name
  policy = data.aws_iam_policy_document.kubernetes_deletion.json
}