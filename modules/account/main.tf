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

module "account_setup" {
  source        = "../setup"
  account_alias = var.account_alias
  environment   = var.environment
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.environment
  cidr = var.cidr

  azs                    = data.aws_availability_zones.current.names
  private_subnets        = [for netnum in range(100, 103) : cidrsubnet(var.cidr, 8, netnum)]
  public_subnets         = [for netnum in range(0, 3) : cidrsubnet(var.cidr, 8, netnum)]
  enable_dns_hostnames   = true
  enable_dns_support     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
}

module "ecs" {
  source = "../ecs"
}

module "jaeger" {
  source      = "../jaeger"
  vpc_id      = module.vpc.vpc_id
  cluster_arn = module.ecs.arn
  subnet_ids  = module.vpc.public_subnets
}


module "vault" {
  source      = "../vault"
  vpc_id      = module.vpc.vpc_id
  cluster_arn = module.ecs.arn
  subnet_ids  = module.vpc.public_subnets
}
