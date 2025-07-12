output "app_env_arn" {
  value = aws_ssm_parameter.app_env.arn
}

output "cors_arn" {
  value = aws_ssm_parameter.cors.arn
}

output "app_port_arn" {
  value = aws_ssm_parameter.app_port.arn
}

output "api_url_arn" {
  value = aws_ssm_parameter.api_url.arn
}

output "jwt_access_secret_arn" {
  value = aws_ssm_parameter.jwt_access_secret.arn
}

output "jwt_refresh_secret_arn" {
  value = aws_ssm_parameter.jwt_refresh_secret.arn
}

output "resume_bucket_name_arn" {
  value = aws_ssm_parameter.resume_bucket_name.arn
}

output "public_bucket_name_arn" {
  value = aws_ssm_parameter.public_bucket_name.arn
}

output "db_host_arn" {
  value = aws_ssm_parameter.db_host.arn
}

output "db_port_arn" {
  value = aws_ssm_parameter.db_port.arn
}

output "db_name_arn" {
  value = aws_ssm_parameter.db_name.arn
}

output "db_user_arn" {
  value = aws_ssm_parameter.db_user.arn
}

output "db_password_arn" {
  value = aws_ssm_parameter.db_password.arn
}

output "no_reply_email_arn" {
  value = aws_ssm_parameter.no_reply_email.arn
}

output "employer_url_arn" {
  value = aws_ssm_parameter.employer_url.arn
}

output "user_url_arn" {
  value = aws_ssm_parameter.user_url.arn
}

output "sentry_dsn_arn" {
  value = aws_ssm_parameter.sentry_dsn.arn
}

output "admin_email_arn" {
  value = aws_ssm_parameter.admin_email.arn
}

output "scheduler_secret_token_arn" {
  value = aws_ssm_parameter.scheduler_secret_token.arn
}

output "admin_token_arn" {
  value = aws_ssm_parameter.admin_token.arn
}
