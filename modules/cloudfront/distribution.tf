locals {
  employer_static_origin_id = "employer_static_s3_origin"
  user_static_origin_id     = "user_static_s3_origin"
  asset_bucket_origin_id    = "asset_bucket_s3_origin"
}

// create cloud front with s3 bucket
resource "aws_cloudfront_distribution" "employer_distribution" {
  // employer static s3 bucket origin
  origin {
    domain_name              = var.employer_static_bucket_domain_name
    origin_id                = local.employer_static_origin_id
    origin_access_control_id = aws_cloudfront_origin_access_control.employer_OAC.id
  }

  // asset bucket origin
  origin {
    domain_name              = var.public_bucket_domain_name
    origin_id                = local.asset_bucket_origin_id
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
      function_arn = aws_cloudfront_function.employer_viewer_request_function.arn
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # Custom behavior for /assets/*
  ordered_cache_behavior {
    path_pattern           = "/assets/*" # Route requests to /assets/*
    target_origin_id       = local.asset_bucket_origin_id
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
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


resource "aws_cloudfront_distribution" "user_distribution" {
  // user static s3 bucket origin
  origin {
    domain_name              = var.user_static_bucket_domain_name
    origin_id                = local.user_static_origin_id
    origin_access_control_id = aws_cloudfront_origin_access_control.user_OAC.id
  }

  origin {
    domain_name              = var.public_bucket_domain_name
    origin_id                = local.asset_bucket_origin_id
    origin_access_control_id = aws_cloudfront_origin_access_control.user_OAC.id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "user S3 bucket distribution"
  default_root_object = "index.html"
  aliases             = ["${var.domain_name}"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.user_static_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.user_viewer_request_function.arn
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
  // Custom behavior for /assets/*
  ordered_cache_behavior {
    path_pattern           = "/assets/*" # Route requests to /assets/*
    target_origin_id       = local.asset_bucket_origin_id
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
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
    Name = "${var.prefix}-user-cloudfront"
  }
}

// create aws_cloudfront_origin_access_control
resource "aws_cloudfront_origin_access_control" "user_OAC" {
  name                              = "s3-user-cloudfront-oac"
  description                       = "Grant cloudfront access to s3 bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
