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
