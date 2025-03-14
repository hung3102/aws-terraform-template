terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.52.0"
    }
  }

  backend "s3" {
    bucket = "terraform-state-your-potential"
    key    = "japan-job"
    region = "ap-northeast-1"
  }

  required_version = "~> 1.9.7"
}

provider "aws" {
  region = "ap-northeast-1"
}

locals {
  prefix = var.prefix
}

module "route53" {
  source      = "../../modules/route53"
  prefix      = local.prefix
  domain_name = var.domain_name
  records     = var.route53_records
}
