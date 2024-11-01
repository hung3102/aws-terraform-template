resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.prefix}-main"
  }

  tags_all = {
    Name = "${var.prefix}-main"
  }
}
