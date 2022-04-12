module "ecs" {
  source             = "terraform-aws-modules/ecs/aws"
  name               = "ECS"
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy = [
    { capacity_provider = "FARGATE_SPOT" }
  ]
}

output "arn" {
  value = module.ecs.ecs_cluster_arn
}