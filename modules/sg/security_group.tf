# ===================== ECS SG ==================================== #
resource "aws_security_group" "ecs_sg" {
  description = "ecs SG"

  name   = "${var.prefix}-ecs"
  vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "ecs_sg" {
  security_group_id = aws_security_group.ecs_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}

resource "aws_vpc_security_group_ingress_rule" "ecs_sg" {
  security_group_id = aws_security_group.ecs_sg.id

  description                  = "allow 3000 from LB"
  from_port                    = "3000"
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.lb_sg.id
  to_port                      = "3000"
}

# ===================== LB SG ==================================== #
resource "aws_security_group" "lb_sg" {
  description = "load balancer SG"

  name   = "${var.prefix}-lb"
  vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "lb_sg" {
  security_group_id = aws_security_group.lb_sg.id

  from_port                    = "3000"
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.ecs_sg.id
  to_port                      = "3000"
}

resource "aws_vpc_security_group_ingress_rule" "lb_sg_allow_http" {
  description       = "allow http from internet"
  security_group_id = aws_security_group.lb_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = "80"
  ip_protocol = "tcp"
  to_port     = "80"
}

resource "aws_vpc_security_group_ingress_rule" "lb_sg_allow_https" {
  description       = "allow https from internet"
  security_group_id = aws_security_group.lb_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = "443"
  ip_protocol = "tcp"
  to_port     = "443"
}
