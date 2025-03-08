output "app_env_arn" {
  value = aws_ssm_parameter.app_env.arn
}

output "jwt_access_secret_arn" {
  value = aws_ssm_parameter.jwt_access_secret.arn
}

output "jwt_refresh_secret_arn" {
  value = aws_ssm_parameter.jwt_refresh_secret.arn
}

output "cors_arn" {
  value = aws_ssm_parameter.cors_arn.arn
}

output "api_url_arn" {
  value = aws_ssm_parameter.api_url_arn.arn
}

output "db_user_arn" {
  value = aws_ssm_parameter.db_user_arn.arn
}

output "db_password_arn" {
  value = aws_ssm_parameter.db_password_arn.arn
}

output "no_reply_email_arn" {
  value = aws_ssm_parameter.no_reply_email_arn.arn
}
