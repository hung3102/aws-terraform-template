resource "aws_route_table_association" "public-1" {
  route_table_id = aws_route_table.public.id
  subnet_id      = var.public_subnet_ids[0]
}

resource "aws_route_table_association" "public-2" {
  route_table_id = aws_route_table.public.id
  subnet_id      = var.public_subnet_ids[1]
}

resource "aws_route_table_association" "private-1" {
  route_table_id = aws_route_table.private.id
  subnet_id      = var.private_subnet_ids[0]
}

resource "aws_route_table_association" "private-2" {
  route_table_id = aws_route_table.private.id
  subnet_id      = var.private_subnet_ids[1]
}
