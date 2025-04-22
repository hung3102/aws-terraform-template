variable "prefix" {
  description = "Name Prefix"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string # development, staging, production
}

variable "ssm_app_env" {
  type = string
}

variable "ssm_jwt_access_secret" {
  type = string
}

variable "ssm_jwt_refresh_secret" {
  type = string
}

variable "ssm_cors" {
  type = string
}

variable "ssm_api_url" {
  type = string
}

variable "ssm_db_name" {
  type = string
}

variable "ssm_db_user" {
  type = string
}

variable "ssm_db_password" {
  type = string
}

variable "ssm_no_reply_email" {
  type = string
}

variable "ssm_employer_url" {
  type = string
}

variable "ssm_user_url" {
  type = string
}

variable "ssm_sentry_dsn" {
  type = string
}

variable "api_service_desired_count" {
  type = number
}

variable "api_container_cpu" {
  type = number
}

variable "api_container_ephemeral_storage_size" {
  type = number
}

variable "api_container_memory" {
  type = number
}

variable "rds_allocated_storage" {
  type = number
}

variable "rds_instance_class" {
  type = string
}

variable "rds_skip_final_snapshot" {
  type = bool
}

variable "bastion_host_instance_type" {
  type = string
}

variable "domain_name" {
  description = "Domain Name"
  type        = string
}

variable "route53_records" {
  description = "A map of record types and their details"
  type = map(map(object({
    name    = string
    records = list(string)
  })))
}
