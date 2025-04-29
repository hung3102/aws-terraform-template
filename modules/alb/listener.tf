resource "aws_lb_listener" "api_http" {
  count             = var.environment == "development" ? 1 : 0 # Create only in dev
  load_balancer_arn = aws_lb.api.arn
  port              = 80
  protocol          = "HTTP"
  # ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.primary.arn
  }

  lifecycle {
    ignore_changes = [
      default_action,
    ]
  }
}

resource "aws_lb_listener" "api_https" {
  load_balancer_arn = aws_lb.api.arn
  port              = 443
  protocol          = "HTTPS"
  # ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.primary.arn
  }

  lifecycle {
    ignore_changes = [
      default_action,
    ]
  }
}
