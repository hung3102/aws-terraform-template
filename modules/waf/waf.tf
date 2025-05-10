# This module creates a WAF Web ACL for Admin IP whitelisting.
resource "aws_wafv2_ip_set" "admin_allowed_ips" {
  name               = "${var.prefix}-admin-allowed-ips"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = var.admin_allowed_ips
}

# Create the Web ACL
resource "aws_wafv2_web_acl" "api_lb_waf" {
  name  = "${var.prefix}-api-waf"
  scope = "REGIONAL" # Important: REGIONAL for ALB

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    sampled_requests_enabled   = true
    metric_name                = "${var.prefix}-api-waf"
  }

  # Block /admin for IPs not in allowed list
  rule {
    name     = "${var.prefix}-block-nonadmin-ips"
    priority = 0

    action {
      block {}
    }

    statement {
      and_statement {
        statement {
          byte_match_statement {
            search_string = "/admin"
            field_to_match {
              uri_path {}
            }
            positional_constraint = "STARTS_WITH"
            text_transformation {
              priority = 0
              type     = "NONE"
            }
          }
        }

        statement {
          not_statement {
            statement {
              ip_set_reference_statement {
                arn = aws_wafv2_ip_set.admin_allowed_ips.arn
              }
            }
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      sampled_requests_enabled   = true
      metric_name                = "${var.prefix}-block-nonadmin-ips"
    }
  }

  // Rate limiting rule
  rule {
    name     = "${var.prefix}-limit-per-ip"
    priority = 1
    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = 2000 # 2000 requests per 5 minutes
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      sampled_requests_enabled   = true
      metric_name                = "${var.prefix}-limit-per-ip"
    }
  }
}

# Associate Web ACL with the Load Balancer
resource "aws_wafv2_web_acl_association" "api_lb_waf_association" {
  resource_arn = var.api_lb_arn
  web_acl_arn  = aws_wafv2_web_acl.api_lb_waf.arn
}
