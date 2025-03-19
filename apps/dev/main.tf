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

# main provider
provider "aws" {
  region = "ap-northeast-1"
}

locals {
  prefix      = var.prefix
  environment = var.environment
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

# Using NAT instance instead because NAT Gateway is too expensive
# module "nat" {
# source           = "../../modules/nat"
# prefix           = local.prefix
# nat_eip_id       = module.eip.nat_eip_id
# public_subnet_id = module.subnet.public_subnet_ids[0]
# internet_gateway = module.igw.internet_gateway
# }

module "routetable" {
  source             = "../../modules/route_table"
  prefix             = local.prefix
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.subnet.private_subnet_ids
  public_subnet_ids  = module.subnet.public_subnet_ids
  # nat_gateway_id     = module.nat.nat_gateway_id
  nat_instance_network_interface_id = module.ec2.bastion_host_network_interface_id
  igw_id                            = module.igw.internet_gateway.id
}


module "iam" {
  source                      = "../../modules/iam"
  prefix                      = local.prefix
  private_subnet_ids          = module.subnet.private_subnet_ids
  employer_static_bucket_name = module.s3.employer_static_bucket_name
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
  lb_target_group_port = 80
  certificate_arn      = module.acm.main_cert_arn
  environment          = local.environment
}

module "s3" {
  source                               = "../../modules/s3"
  prefix                               = local.prefix
  employer_cloudfront_distribution_arn = module.cloudfront.employer_distribution_arn
}

module "acm" {
  source              = "../../modules/acm"
  prefix              = local.prefix
  domain_name         = var.domain_name
  route53_acm_records = module.route53.acm_records
}

module "cloudfront" {
  source                             = "../../modules/cloudfront"
  prefix                             = local.prefix
  employer_static_bucket_domain_name = module.s3.employer_static_bucket_domain_name
  acm_cert_arn                       = module.acm.us_east_cert_arn
  domain_name                        = var.domain_name
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
  prefix             = local.prefix
  app_env            = var.ssm_app_env
  cors               = var.ssm_cors
  app_port           = 3000
  api_url            = var.ssm_api_url
  jwt_access_secret  = var.ssm_jwt_access_secret
  jwt_refresh_secret = var.ssm_jwt_refresh_secret
  resume_bucket_name = module.s3.resume_bucket_name
  public_bucket_name = module.s3.public_bucket_name
  db_host            = module.rds.db_host
  db_port            = module.rds.db_port
  db_name            = var.ssm_db_name
  db_user            = var.ssm_db_user
  db_password        = var.ssm_db_password
  no_reply_email     = var.ssm_no_reply_email
  employer_url       = var.ssm_employer_url
}

module "ecs" {
  source                               = "../../modules/ecs"
  prefix                               = local.prefix
  private_subnet_ids                   = module.subnet.private_subnet_ids
  api_container_name                   = "${local.prefix}-api"
  api_service_desired_count            = var.api_service_desired_count
  api_ecs_sg_id                        = module.sg.ecs_sg_id
  api_ecr_repository_url               = module.ecr.ecr_repository_url
  api_container_cpu                    = var.api_container_cpu
  api_container_ephemeral_storage_size = var.api_container_ephemeral_storage_size
  api_container_memory                 = var.api_container_memory
  execution_role_arn                   = module.iam.ecs_task_execution_role_arn
  api_ecs_task_role_arn                = module.iam.ecs_task_role_arn
  container_port                       = 3000
  lb_target_group_arn                  = module.lb.target_group_primary_arn
  sg_ids                               = [module.sg.ecs_sg_id]
  api_lb                               = [module.lb.api_lb]
  ssm_app_env_arn                      = module.ssm.app_env_arn
  ssm_cors_arn                         = module.ssm.cors_arn
  ssm_app_port_arn                     = module.ssm.app_port_arn
  ssm_api_url_arn                      = module.ssm.api_url_arn
  ssm_jwt_access_secret_arn            = module.ssm.jwt_access_secret_arn
  ssm_jwt_refresh_secret_arn           = module.ssm.jwt_refresh_secret_arn
  ssm_resume_bucket_name_arn           = module.ssm.resume_bucket_name_arn
  ssm_public_bucket_name_arn           = module.ssm.public_bucket_name_arn
  ssm_db_host_arn                      = module.ssm.db_host_arn
  ssm_db_port_arn                      = module.ssm.db_port_arn
  ssm_db_name_arn                      = module.ssm.db_name_arn
  ssm_db_user_arn                      = module.ssm.db_user_arn
  ssm_db_password_arn                  = module.ssm.db_password_arn
  ssm_no_reply_email_arn               = module.ssm.no_reply_email_arn
  ssm_employer_url_arn                 = module.ssm.employer_url_arn
}

module "rds" {
  source                    = "../../modules/rds"
  prefix                    = local.prefix
  allocated_storage         = var.rds_allocated_storage
  db_name                   = var.ssm_db_name
  db_username               = var.ssm_db_user
  db_password               = var.ssm_db_password
  skip_final_snapshot       = var.rds_skip_final_snapshot
  rds_sg_id                 = module.sg.rds_sg_id
  instance_class            = var.rds_instance_class
  private_subnet_group_name = module.subnet.private_subnet_group_name
}

module "ec2" {
  source                          = "../../modules/ec2"
  prefix                          = local.prefix
  bastion_host_instance_type      = var.bastion_host_instance_type
  bastion_host_eip_id             = module.eip.bastion_host_eip_id
  public_subnet_ids               = module.subnet.public_subnet_ids
  bastion_host_security_group_ids = [module.sg.bastion_host_sg_id]
  db_host                         = module.rds.db_host
  db_port                         = module.rds.db_port
  db_name                         = module.rds.db_name
  db_user                         = var.ssm_db_user
  db_password                     = var.ssm_db_password
  bastion_host_role_name          = module.iam.bastion_host_role_name
}

module "route53" {
  source                             = "../../modules/route53"
  prefix                             = local.prefix
  domain_name                        = var.domain_name
  records                            = var.route53_records
  lb_api_dns_name                    = module.lb.api_lb.dns_name
  lb_api_hosted_zone_id              = module.lb.api_lb.zone_id
  cloudfront_employer_domain_name    = module.cloudfront.employer_domain_name
  cloudfront_employer_hosted_zone_id = module.cloudfront.employer_hosted_zone_id
  acm_domain_validation_options      = module.acm.domain_validation_options
}
