resource "aws_ecs_cluster" "api" {
  configuration {
    execute_command_configuration {
      logging = "DEFAULT"
    }
  }

  name = "${var.prefix}-api"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
