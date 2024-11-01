resource "aws_ssm_parameter" "app_env" {
  name  = "APP_ENV"
  type  = "String"
  value = var.app_env
}

resource "aws_ssm_parameter" "app_port" {
  name  = "APP_PORT"
  type  = "String"
  value = var.app_port
}

resource "aws_ssm_parameter" "jwt_access_secret" {
  name  = "JWT_ACCESS_SECRET"
  type  = "String"
  value = var.jwt_access_secret
}

resource "aws_ssm_parameter" "jwt_refresh_secret" {
  name  = "JWT_REFRESH_SECRET"
  type  = "String"
  value = var.jwt_refresh_secret
}
