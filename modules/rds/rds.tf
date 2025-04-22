// create rds mysql instance
resource "aws_db_instance" "job-board" {
  identifier             = "${var.prefix}-job-board"
  allocated_storage      = var.allocated_storage
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.4"
  instance_class         = var.instance_class
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.mysql8.4"
  publicly_accessible    = false
  skip_final_snapshot    = var.skip_final_snapshot
  vpc_security_group_ids = [var.rds_sg_id]
  db_subnet_group_name   = var.private_subnet_group_name
  db_name                = var.db_name


  # Prevent accidental deletion
  deletion_protection = true
  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "${var.prefix}-job-board"
  }
}
