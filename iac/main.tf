module "network" {
  source = "./modules/network"

  owner        = var.owner
  aws_region   = var.aws_region
  project_name = var.project_name
  tags         = local.tags
}

module "iam" {
  source = "./modules/iam"

  owner        = var.owner
  aws_region   = var.aws_region
  project_name = var.project_name
  tags         = local.tags
}

module "s3" {
  source = "./modules/s3"

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

module "sm" {
  source = "./modules/sm"

  owner                  = var.owner
  aws_region             = var.aws_region
  project_name           = var.project_name
  rds_address            = module.rds.rds_address
  rds_db_name            = module.rds.rds_db_name
  rds_port               = module.rds.rds_port
  rds_user               = module.rds.rds_user
  rds_password           = module.rds.rds_password
  s3_bucket_name         = module.s3.s3_bucket_name
  iam_user_access_id     = module.iam.iam_user_access_id
  iam_user_access_secret = module.iam.iam_user_access_secret
  tags                   = local.tags

  depends_on = [module.rds, module.iam, module.s3]
}

module "ec2" {
  source = "./modules/ec2"

  owner                = var.owner
  aws_region           = var.aws_region
  project_name         = var.project_name
  public_subnets       = module.network.public_subnets_id
  iam_instance_profile = module.iam.iam_instance_profile
  sg_ec2               = [module.network.sg_ec2_id]
  tags                 = local.tags

  depends_on = [module.rds, module.sm]
}

module "alb" {
  source = "./modules/alb"

  owner          = var.owner
  aws_region     = var.aws_region
  project_name   = var.project_name
  domain_name    = var.domain_name
  vpc_id         = module.network.vpc_id
  public_subnets = module.network.public_subnets_id
  sg_alb         = [module.network.sg_alb_id]
  tags           = local.tags

}

module "ecr" {
  source = "./modules/ecr"

  owner        = var.owner
  aws_region   = var.aws_region
  project_name = var.project_name
  tags         = local.tags
}

module "ecs" {
  source = "./modules/ecs"

  owner           = var.owner
  aws_region      = var.aws_region
  project_name    = var.project_name
  alb_tg_id       = module.alb.alb_tg_id
  container_image = module.ecr.repository_uri
  iam_role_ecs    = module.iam.iam_role_ecs
  vpc_id          = module.network.vpc_id
  public_subnets  = module.network.public_subnets_id
  sg_ecs          = [module.network.sg_ecs_id]
  tags            = local.tags

  depends_on = [module.alb, module.ecr]
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
  iam_instance_profile = module.iam.iam_instance_profile
  sg_ec2               = [module.network.sg_ec2_id]
  tags                 = local.tags
  tags_asg             = local.tags_asg

  depends_on = [module.alb]
}
