# ===================== ECS SG ==================================== #
resource "aws_security_group" "ecs_sg" {
  description = "ecs SG"
  name        = "${var.prefix}-ecs"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.prefix}-ecs"
  }
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

  tags = {
    Name = "${var.prefix}-lb"
  }
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

# ===================== RDS SG ==================================== #
resource "aws_security_group" "rds_sg" {
  name        = "${var.prefix}-db-security-group"
  description = "Allow inbound MySQL access"
  vpc_id      = var.vpc_id

  # Allow MySQL connections (port 3306) from a specific IP or security group
  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    security_groups = [
      aws_security_group.ecs_sg.id,
      aws_security_group.bastion_host_sg.id
    ] # Allow only from ECS SG and Bastion
  }

  # Allow outbound connections (e.g., for database updates)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}-rds-security-group"
  }
}

# ===================== EC2 BASTION HOST SG ==================================== #
resource "aws_security_group" "bastion_host_sg" {
  description = "bastion host SG"

  name   = "${var.prefix}-bastion"
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}-bastion"
  }
}

# Allow SSH connections from internet
resource "aws_vpc_security_group_ingress_rule" "bastion_host_sg_allow_all_ssh" {
  description       = "allow ssh from internet"
  security_group_id = aws_security_group.bastion_host_sg.id

  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
}

# Allow https form ecs sg
resource "aws_vpc_security_group_ingress_rule" "bastion_host_sg_allow_ecs_https" {
  description       = "allow https from ecs"
  security_group_id = aws_security_group.bastion_host_sg.id

  from_port                    = 443
  to_port                      = 443
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.ecs_sg.id
}

# Allow ping from all
resource "aws_vpc_security_group_ingress_rule" "bastion_host_sg_allow_all_ping" {
  description       = "allow ping from all"
  security_group_id = aws_security_group.bastion_host_sg.id

  from_port   = -1
  to_port     = -1
  ip_protocol = "icmp"
  cidr_ipv4   = "0.0.0.0/0"
}
