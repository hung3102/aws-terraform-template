output "main_cert_arn" {
  value = aws_acm_certificate.main.arn
}

output "us_east_cert_arn" {
  value = aws_acm_certificate.us_east_acm.arn
}

output "domain_validation_options" {
  value = aws_acm_certificate.main.domain_validation_options
}
