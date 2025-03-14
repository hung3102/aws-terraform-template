// create route53 hosted zone
resource "aws_route53_zone" "main" {
  name = var.domain_name
}

resource "aws_route53_record" "records" {
  for_each = merge([
    for record_type, records in var.records : {
      for key, record in records : "${record_type}.${key}" => {
        type    = record_type
        name    = "${record.name}.${var.domain_name}"
        records = record.records
      }
    }
  ]...)

  zone_id = aws_route53_zone.main.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 300
  records = each.value.records
}

// create route53 record for api transfer to LB
resource "aws_route53_record" "api" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "api.${var.domain_name}"
  type    = "A"
  alias {
    name                   = var.lb_api_dns_name
    zone_id                = var.lb_api_hosted_zone_id
    evaluate_target_health = false
  }
}

// create route53 record for transfer to employer Cloudfront
resource "aws_route53_record" "cloudfront" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "employer.${var.domain_name}"
  type    = "A"
  alias {
    name                   = var.cloudfront_employer_domain_name
    zone_id                = var.cloudfront_employer_hosted_zone_id
    evaluate_target_health = false
  }
}

// create acm record for validation
resource "aws_route53_record" "acm_records" {
  for_each = {
    for dvo in var.acm_domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.main.zone_id
}
