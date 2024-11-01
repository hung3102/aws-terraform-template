resource "aws_ecs_task_definition" "api" {
  container_definitions = jsonencode(
    [
      {
        "cpu" : 0,
        "secrets" : [
          {
            "name" : "APP_ENV",
            "valueFrom" : var.ssm_app_env_ern
          },
          {
            "name" : "APP_PORT",
            "valueFrom" : var.ssm_app_port_ern
          },
          {
            "name" : "JWT_ACCESS_SECRET"
            "valueFrom" : var.ssm_jwt_access_secret_arn
          },
          {
            "name" : "JWT_REFRESH_SECRET"
            "valueFrom" : var.ssm_jwt_refresh_secret_arn
          }
        ],
        "environmentFiles" : [],
        "essential" : true,
        "image" : var.api_ecr_repository_url,
        "logConfiguration" : {
          "logDriver" : "awslogs",
          "options" : {
            "awslogs-create-group" : "true",
            "awslogs-group" : "/ecs/${var.api_container_name}",
            "awslogs-region" : "ap-northeast-1",
            "awslogs-stream-prefix" : var.api_container_name
          },
          "secretOptions" : []
        },
        "mountPoints" : [],
        "name" : var.api_container_name,
        "portMappings" : [
          {
            "containerPort" : var.container_port,
            "hostPort" : var.container_port,
            "name" : tostring(var.container_port),
            "protocol" : "tcp"
          }
        ],
        "systemControls" : [],
        "volumesFrom" : []
      }
    ]
  )

  cpu = var.api_container_cpu

  ephemeral_storage {
    size_in_gib = var.api_container_ephemeral_storage_size
  }

  execution_role_arn       = var.execution_role_arn
  family                   = "${var.prefix}-api"
  memory                   = var.api_container_memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }

  task_role_arn = var.api_ecs_task_role_arn
  track_latest  = "false"
}
