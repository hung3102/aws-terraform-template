resource "aws_ssm_parameter" "app_env" {
  name  = "${var.prefix}-APP_ENV"
  type  = "String"
  value = var.app_env
}

resource "aws_ssm_parameter" "cors" {
  name  = "${var.prefix}-CORS"
  type  = "String"
  value = var.cors
}

resource "aws_ssm_parameter" "app_port" {
  name  = "${var.prefix}-APP_PORT"
  type  = "String"
  value = var.app_port
}

resource "aws_ssm_parameter" "api_url" {
  name  = "${var.prefix}-API_URL"
  type  = "String"
  value = var.api_url
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

resource "aws_ssm_parameter" "resume_bucket_name" {
  name  = "${var.prefix}-RESUME_BUCKET_NAME"
  type  = "String"
  value = var.resume_bucket_name
}

resource "aws_ssm_parameter" "public_bucket_name" {
  name  = "${var.prefix}-PUBLIC_BUCKET_NAME"
  type  = "String"
  value = var.public_bucket_name
}

resource "aws_ssm_parameter" "db_host" {
  name  = "${var.prefix}-DB_HOST"
  type  = "SecureString"
  value = var.db_host
}

resource "aws_ssm_parameter" "db_port" {
  name  = "${var.prefix}-DB_PORT"
  type  = "String"
  value = var.db_port
}

resource "aws_ssm_parameter" "db_name" {
  name  = "${var.prefix}-DB_NAME"
  type  = "SecureString"
  value = var.db_name
}

resource "aws_ssm_parameter" "db_user" {
  name  = "${var.prefix}-DB_USER"
  type  = "SecureString"
  value = var.db_user
}

resource "aws_ssm_parameter" "db_password" {
  name  = "${var.prefix}-DB_PASSWORD"
  type  = "SecureString"
  value = var.db_password
}

resource "aws_ssm_parameter" "no_reply_email" {
  name  = "${var.prefix}-NO_REPLY_EMAIL"
  type  = "String"
  value = var.no_reply_email
}

resource "aws_ssm_parameter" "employer_url" {
  name  = "${var.prefix}-EMPLOYER_URL"
  type  = "String"
  value = var.employer_url
}
