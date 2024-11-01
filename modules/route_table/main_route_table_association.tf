resource "aws_main_route_table_association" "main" {
  route_table_id = aws_route_table.private.id
  vpc_id         = var.vpc_id
}
