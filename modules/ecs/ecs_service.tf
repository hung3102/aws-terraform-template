resource "aws_ecs_service" "api" {
  cluster    = aws_ecs_cluster.api.id
  depends_on = [var.api_lb]

  lifecycle {
    ignore_changes = [
      task_definition,
    ]
  }

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  deployment_maximum_percent         = "200"
  deployment_minimum_healthy_percent = "100"
  desired_count                      = var.api_service_desired_count
  enable_ecs_managed_tags            = "true"
  enable_execute_command             = "false"
  health_check_grace_period_seconds  = "5"
  launch_type                        = "FARGATE"

  load_balancer {
    container_name   = var.api_container_name
    container_port   = var.container_port
    target_group_arn = var.lb_target_group_arn
  }

  name = "${var.prefix}-api"

  network_configuration {
    assign_public_ip = "false"
    security_groups  = var.sg_ids
    subnets          = var.private_subnet_ids
  }

  platform_version    = "1.4.0"
  scheduling_strategy = "REPLICA"
  task_definition     = aws_ecs_task_definition.api.arn
}
