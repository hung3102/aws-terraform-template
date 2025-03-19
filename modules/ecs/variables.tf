variable "prefix" {
  description = "Name Prefix"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private Subnet IDs"
  type        = list(string)
}

variable "api_container_name" {
  description = "API Container Name"
  type        = string
}

variable "api_service_desired_count" {
  description = "Desired Count"
  type        = number
}

variable "api_lb" {
  description = "API LB"
}

variable "lb_target_group_arn" {
  description = "LB Target Group ARN"
  type        = string
}

variable "api_ecs_sg_id" {
  description = "ECS SG ID"
  type        = string
}

variable "api_ecr_repository_url" {
  description = "ECR Repository URL"
  type        = string
}

variable "api_container_cpu" {
  description = "API Container CPU"
  type        = number # ex: "256"
}

variable "api_container_ephemeral_storage_size" {
  description = "API Container Ephemeral Storage"
  type        = number # ex: "50"
}

variable "api_container_memory" {
  description = "API Container Memory"
  type        = number # ex: "512"
}

variable "execution_role_arn" {
  description = "Execution Role ARN"
  type        = string
}

variable "api_ecs_task_role_arn" {
  description = "API ECS Task Role ARN"
  type        = string
}

variable "container_port" {
  description = "Container Port"
  type        = number # 3000
}

variable "sg_ids" {
  description = "SG IDs"
  type        = list(string)
}

variable "ssm_app_env_arn" {
  description = "SSM APP_ENV ARN"
  type        = string
}

variable "ssm_cors_arn" {
  description = "SSM CORS ARN"
  type        = string
}

variable "ssm_app_port_arn" {
  description = "SSM APP_PORT ARN"
  type        = string
}

variable "ssm_api_url_arn" {
  description = "SSM API URL ARN"
  type        = string
}

variable "ssm_jwt_access_secret_arn" {
  description = "SSM JWT_ACCESS_SECRET ARN"
  type        = string
}

variable "ssm_jwt_refresh_secret_arn" {
  description = "SSM JWT_REFRESH_SECRET ARN"
  type        = string
}

variable "ssm_resume_bucket_name_arn" {
  description = "SSM RESUME_BUCKET_NAME ARN"
  type        = string
}

variable "ssm_public_bucket_name_arn" {
  description = "SSM PUBLIC_BUCKET_NAME ARN"
  type        = string
}

variable "ssm_db_host_arn" {
  description = "SSM DB_HOST ARN"
  type        = string
}

variable "ssm_db_port_arn" {
  description = "SSM DB_PORT ARN"
  type        = string
}

variable "ssm_db_name_arn" {
  description = "SSM DB Name ARN"
  type        = string
}

variable "ssm_db_user_arn" {
  description = "DB User ARN"
  type        = string
}

variable "ssm_db_password_arn" {
  description = "DB Password ARN"
  type        = string
}

variable "ssm_no_reply_email_arn" {
  description = "SSM NO_REPLY_EMAIL ARN"
  type        = string
}

variable "ssm_employer_url_arn" {
  description = "SSM EMPLOYER_URL ARN"
  type        = string
}
