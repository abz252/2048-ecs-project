module "vpc" {
  source = "../modules/vpc"

  vpc_cidr_block       = "10.0.0.0/16"
  public_subnet_cidr1  = "10.0.0.0/24"
  private_subnet_cidr1 = "10.0.1.0/24"
  public_subnet_cidr2  = "10.0.10.0/24"
  private_subnet_cidr2 = "10.0.11.0/24"
  tags                 = local.tags
}

module "security_groups" {
  source = "../modules/security-groups"

  vpc_id = module.vpc.vpc_id
  tags   = local.tags
}

module "ecr" {
  source = "../modules/ecr"
  tags   = local.tags
}

module "iam" {
  source = "../modules/iam"
  tags   = local.tags

}

module "alb" {
  source = "../modules/alb"

  aws_security_group_alb_id = module.security_groups.aws_security_group_alb_id
  public_subnets_ids        = [module.vpc.subnet_public1_id, module.vpc.subnet_public2_id]
  vpc_id                    = module.vpc.vpc_id
  acm_validation_arn        = module.route53.acm_validation_arn
  tags                      = local.tags
}

module "ecs" {
  source = "../modules/ecs"

  taskexecution_role_arn = module.iam.aws_iam_role_ecs_arn
  target_group_arn       = module.alb.target_group_arn
  ecs_sg                 = module.security_groups.aws_security_group_ecs_id
  subnets                = [module.vpc.subnet_private1_id, module.vpc.subnet_private2_id]
  tags                   = local.tags

}

module "route53" {
  source = "../modules/route53"

  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
}

module "cloudwatch" {
  source = "../modules/cloudwatch"

  load_balancer_suffix_arn = module.alb.aws_lb_alb_suffix_arn
  service_name             = module.ecs.aws_ecs_service_game_2048_name
  cluster_name             = module.ecs.aws_ecs_cluster_game_2048_name
  tags                     = local.tags
} 