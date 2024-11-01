resource "aws_lb_listener" "api" {
  load_balancer_arn = aws_lb.api.arn
  port              = var.lb_port
  protocol          = var.protocol
  # ssl_policy        = "ELBSecurityPolicy-2016-08"
  # certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.primary.arn
  }
}
