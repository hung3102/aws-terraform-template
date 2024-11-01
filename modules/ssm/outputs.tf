output "app_env_arn" {
  value = aws_ssm_parameter.app_env.arn
}

output "app_port_arn" {
  value = aws_ssm_parameter.app_port.arn
}

output "jwt_access_secret_arn" {
  value = aws_ssm_parameter.jwt_access_secret.arn
}

output "jwt_refresh_secret_arn" {
  value = aws_ssm_parameter.jwt_refresh_secret.arn
}
