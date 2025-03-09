output "db_host" {
  value = aws_db_instance.job-board.address
}

output "db_port" {
  value = aws_db_instance.job-board.port
}

output "db_name" {
  value = aws_db_instance.job-board.db_name
}
