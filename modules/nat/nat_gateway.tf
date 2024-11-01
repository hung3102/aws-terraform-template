resource "aws_nat_gateway" "main" {
  allocation_id     = var.nat_eip_id
  connectivity_type = "public"
  subnet_id         = var.public_subnet_id

  tags = {
    Name = "${var.prefix}-main"
  }

  tags_all = {
    Name = "${var.prefix}-main"
  }

  depends_on = [var.internet_gateway]
}
