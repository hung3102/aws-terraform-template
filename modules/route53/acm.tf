# Define a separate provider for ACM in us-east-1 (CloudFront requirement)
provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

// create main acm in ap-northeast-1
resource "aws_acm_certificate" "main" {
  domain_name               = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method         = "DNS"
  tags = {
    Name = "${var.prefix}-acm"
  }
}

// create acm for cloudfront
resource "aws_acm_certificate" "us_east_acm" {
  provider                  = aws.us-east-1
  domain_name               = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method         = "DNS"
  tags = {
    Name = "${var.prefix}-acm"
  }
}

resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = [for record in aws_route53_record.acm_records : record.fqdn]
}
