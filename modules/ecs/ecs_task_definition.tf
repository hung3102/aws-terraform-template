resource "aws_ecs_task_definition" "api" {
  container_definitions = jsonencode(
    [
      {
        "cpu" : 0,
        "environment" : [
          {
            "name" : "APP_PORT",
            "value" : var.app_port
          },
          {
            "name" : "AWS_REGION",
            "value" : "ap-northeast-1"
          },
          {
            "name" : "RESUME_BUCKET_NAME",
            "value" : var.resume_bucket_name
          },
          {
            "name" : "PUBLIC_BUCKET_NAME",
            "value" : var.public_bucket_name
          },
          {
            "name" : "DB_HOST",
            "value" : var.db_host
          },
          {
            "name" : "DB_PORT",
            "value" : var.db_port
          },
          {
            "name" : "DB_NAME",
            "value" : var.db_name
          },
          {
            "name" : "DB_USER",
            "value" : var.ssm_db_user_arn
          },
          {
            "name" : "DB_PASSWORD",
            "value" : var.ssm_db_password_arn
          },
          {
            "name" : "NO_REPLY_EMAIL",
            "value" : var.ssm_no_reply_email_arn
          }
        ],
        "secrets" : [
          {
            "name" : "APP_ENV",
            "valueFrom" : var.ssm_app_env_arn
          },
          {
            "name" : "CORS",
            "valueFrom" : var.ssm_cors_arn
          },
          {
            "name" : "API_URL",
            "valueFrom" : var.ssm_api_url_arn
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
