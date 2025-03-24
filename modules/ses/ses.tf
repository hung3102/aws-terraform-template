resource "aws_ses_domain_identity" "main" {
  domain = var.domain
}

resource "aws_ses_domain_dkim" "dkim_identity" {
  domain = aws_ses_domain_identity.main.domain
}

resource "aws_ses_domain_identity_verification" "domain_identity_verification" {
  domain     = aws_ses_domain_identity.main.id
  depends_on = [var.amazonses_dkim_record]
}
