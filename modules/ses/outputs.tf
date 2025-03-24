output "dkim_tokens" {
  value = aws_ses_domain_dkim.dkim_identity.dkim_tokens
}
