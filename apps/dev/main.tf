terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.52.0"
    }
  }

  backend "s3" {
    bucket = "terraform-state-your-potential-dev"
    key    = "japan-job"
    region = "ap-northeast-1"
  }

  required_version = "~> 1.9.7"
}

provider "aws" {
  region  = "ap-northeast-1"
  profile = var.aws_profile
}

locals {
  prefix = "tf-dev"
}

module "vpc" {
  source = "../../modules/vpc"
  prefix = local.prefix
}

module "igw" {
  source = "../../modules/igw"
  prefix = local.prefix
  vpc_id = module.vpc.vpc_id
}

module "subnet" {
  source = "../../modules/subnet"
  prefix = local.prefix
  vpc_id = module.vpc.vpc_id
}
module "eip" {
  source = "../../modules/eip"
}

module "nat" {
  source           = "../../modules/nat"
  prefix           = local.prefix
  nat_eip_id       = module.eip.nat_eip_id
  public_subnet_id = module.subnet.public_subnet_ids[0]
  internet_gateway = module.igw.internet_gateway
}

module "routetable" {
  source             = "../../modules/route_table"
  prefix             = local.prefix
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.subnet.private_subnet_ids
  public_subnet_ids  = module.subnet.public_subnet_ids
  nat_gateway_id     = module.nat.nat_gateway_id
  igw_id             = module.igw.internet_gateway.id
}


module "iam" {
  source             = "../../modules/iam"
  prefix             = local.prefix
  private_subnet_ids = module.subnet.private_subnet_ids
}

module "sg" {
  source = "../../modules/sg"
  prefix = local.prefix
  vpc_id = module.vpc.vpc_id
}

module "lb" {
  source               = "../../modules/alb"
  prefix               = local.prefix
  vpc_id               = module.vpc.vpc_id
  public_subnet_ids    = module.subnet.public_subnet_ids
  lb_sg_ids            = [module.sg.lb_sg_id]
  lb_port              = 80
  protocol             = "HTTP"
  lb_target_group_port = 80
}

module "ecr" {
  source             = "../../modules/ecr"
  prefix             = local.prefix
  private_subnet_ids = module.subnet.private_subnet_ids
}

module "codedeploy" {
  source                     = "../../modules/codedeploy"
  prefix                     = local.prefix
  codedeploy_role_arn        = module.iam.codedeploy_role_arn
  ecs_cluster_name           = module.ecs.cluster_name
  ecs_service_name           = module.ecs.service_name
  lb_listener_arn            = module.lb.lb_listener_arn
  lb_blue_target_group_name  = module.lb.target_group_primary_name
  lb_green_target_group_name = module.lb.target_group_secondary_name
}

module "ssm" {
  source             = "../../modules/ssm"
  app_env            = var.ssm_app_env
  app_port           = var.ssm_app_port
  jwt_access_secret  = var.ssm_jwt_access_secret
  jwt_refresh_secret = var.ssm_jwt_refresh_secret
}

module "ecs" {
  source                               = "../../modules/ecs"
  prefix                               = local.prefix
  private_subnet_ids                   = module.subnet.private_subnet_ids
  api_container_name                   = "${local.prefix}-api"
  api_service_desired_count            = 1
  api_ecs_sg_id                        = module.sg.ecs_sg_id
  api_ecr_repository_url               = module.ecr.ecr_repository_url
  api_container_cpu                    = 256
  api_container_ephemeral_storage_size = 50
  api_container_memory                 = 512
  execution_role_arn                   = module.iam.ecs_task_execution_role_arn
  api_ecs_task_role_arn                = module.iam.ecs_task_role_arn
  container_port                       = 3000
  lb_target_group_arn                  = module.lb.target_group_primary_arn
  sg_ids                               = [module.sg.ecs_sg_id]
  api_lb                               = [module.lb.api_lb]
  ssm_app_env_ern                      = module.ssm.app_env_arn
  ssm_app_port_ern                     = module.ssm.app_port_arn
  ssm_jwt_access_secret_arn            = module.ssm.jwt_access_secret_arn
  ssm_jwt_refresh_secret_arn           = module.ssm.jwt_refresh_secret_arn
}

