module "network" {
  source = "./modules/network"

  owner        = var.owner
  aws_region   = var.aws_region
  project_name = var.project_name
  tags         = local.tags
}

module "rds" {
  source = "./modules/rds"

  owner            = var.owner
  aws_region       = var.aws_region
  project_name     = var.project_name
  db_group_private = module.network.db_group_private_id
  sg_rds           = [module.network.sg_rds_id]
  tags             = local.tags

  depends_on = [module.network]
}

module "ec2" {
  source = "./modules/ec2"

  owner          = var.owner
  aws_region     = var.aws_region
  project_name   = var.project_name
  public_subnets = module.network.public_subnets_id
  sg_ec2         = [module.network.sg_ec2_id]
  tags           = local.tags

  depends_on = [module.rds]
}

module "alb" {
  source = "./modules/alb"

  owner          = var.owner
  aws_region     = var.aws_region
  project_name   = var.project_name
  domain_name    = var.domain_name
  vpc_id         = module.network.vpc_id
  public_subnets = module.network.public_subnets_id
  ec2_id         = module.ec2.ec2_id
  sg_alb         = [module.network.sg_alb_id]
  tags           = local.tags

  depends_on = [module.ec2]
}

module "as" {
  source = "./modules/as"

  owner                = var.owner
  aws_region           = var.aws_region
  project_name         = var.project_name
  public_subnets       = module.network.public_subnets_id
  alb_tg_id            = module.alb.alb_tg_id
  key_name             = module.ec2.key_name
  ec2_instance_type    = module.ec2.ec2_instance_type
  ec2_monitoring       = module.ec2.ec2_monitoring
  iam_instance_profile = module.ec2.iam_instance_profile
  sg_ec2               = [module.network.sg_ec2_id]
  tags                 = local.tags
  tags_asg             = local.tags_asg

  depends_on = [module.alb]
}
