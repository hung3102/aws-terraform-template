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

variable "ssm_app_env_ern" {
  description = "SSM APP_ENV ARN"
  type        = string
}

variable "ssm_app_port_ern" {
  description = "SSM APP_PORT ARN"
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
