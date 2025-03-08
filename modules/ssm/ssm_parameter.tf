resource "aws_ssm_parameter" "app_env" {
  name  = "${var.prefix}-APP_ENV"
  type  = "String"
  value = var.app_env
}

resource "aws_ssm_parameter" "jwt_access_secret" {
  name  = "${var.prefix}-JWT_ACCESS_SECRET"
  type  = "String"
  value = var.jwt_access_secret
}

resource "aws_ssm_parameter" "jwt_refresh_secret" {
  name  = "${var.prefix}-JWT_REFRESH_SECRET"
  type  = "String"
  value = var.jwt_refresh_secret
}

resource "aws_ssm_parameter" "cors_arn" {
  name  = "${var.prefix}-CORS"
  type  = "String"
  value = var.cors
}

resource "aws_ssm_parameter" "api_url_arn" {
  name  = "${var.prefix}-API_URL"
  type  = "String"
  value = var.api_url
}

resource "aws_ssm_parameter" "db_user_arn" {
  name  = "${var.prefix}-DB_USER"
  type  = "String"
  value = var.db_user
}

resource "aws_ssm_parameter" "db_password_arn" {
  name  = "${var.prefix}-DB_PASSWORD"
  type  = "String"
  value = var.db_password
}

resource "aws_ssm_parameter" "no_reply_email_arn" {
  name  = "${var.prefix}-DB_HOST"
  type  = "String"
  value = var.no_reply_email
}
