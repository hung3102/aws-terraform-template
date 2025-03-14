locals {
  employer_static_origin_id = "employer_static_s3_origin"
}

// create cloud front with s3 bucket
resource "aws_cloudfront_distribution" "employer_distribution" {
  origin {
    domain_name              = var.employer_static_bucket_domain_name
    origin_id                = local.employer_static_origin_id
    origin_access_control_id = aws_cloudfront_origin_access_control.employer_OAC.id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "employer S3 bucket distribution"
  default_root_object = "index.html"
  aliases             = ["employer.${var.domain_name}"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.employer_static_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.append_html_suffix.arn
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.acm_cert_arn
    ssl_support_method  = "sni-only"
  }

  tags = {
    Name = "${var.prefix}-employer-cloudfront"
  }
}

// create aws_cloudfront_origin_access_control
resource "aws_cloudfront_origin_access_control" "employer_OAC" {
  name                              = "s3-employer-cloudfront-oac"
  description                       = "Grant cloudfront access to s3 bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
