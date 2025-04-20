output "acm_records" {
  value = aws_route53_record.acm_records
}

output "amazonses_dkim_record" {
  value = aws_route53_record.amazonses_dkim_record
}

output "us_east_cert_arn" {
  value = aws_acm_certificate.us_east_acm.arn
}

output "main_cert_arn" {
  value = aws_acm_certificate.main.arn
}
