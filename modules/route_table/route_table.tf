resource "aws_route_table" "private" {
  # route {
  #   cidr_block     = "0.0.0.0/0"
  #   nat_gateway_id = var.nat_gateway_id
  # }

  tags = {
    Name = "${var.prefix}-private"
  }

  tags_all = {
    Name = "${var.prefix}-private"
  }

  vpc_id = var.vpc_id
}

# Route table entry to forward traffic to NAT instance
resource "aws_route" "private_to_nat_instance" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = var.nat_instance_network_interface_id
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
