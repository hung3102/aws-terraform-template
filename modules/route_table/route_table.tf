resource "aws_route_table" "private" {
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id
  }

  tags = {
    Name = "${var.prefix}-private"
  }

  tags_all = {
    Name = "${var.prefix}-private"
  }

  vpc_id = var.vpc_id
}

resource "aws_route_table" "public" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "${var.prefix}-public"
  }

  tags_all = {
    Name = "${var.prefix}-public"
  }

  vpc_id = var.vpc_id
}