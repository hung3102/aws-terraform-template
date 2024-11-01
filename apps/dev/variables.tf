variable "aws_profile" {
  description = "AWS Profile"
  type        = string
}

variable "ssm_app_env" {
  type = string
}

variable "ssm_app_port" {
  type = string
}

variable "ssm_jwt_access_secret" {
  type = string
}

variable "ssm_jwt_refresh_secret" {
  type = string
}
