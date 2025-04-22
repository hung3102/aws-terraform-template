resource "aws_ecs_task_definition" "api" {
  container_definitions = jsonencode(
    [
      {
        "cpu" : 0,
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
            "name" : "APP_PORT",
            "valueFrom" : var.ssm_app_port_arn
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
          },
          {
            "name" : "RESUME_BUCKET_NAME",
            "valueFrom" : var.ssm_resume_bucket_name_arn
          },
          {
            "name" : "PUBLIC_BUCKET_NAME",
            "valueFrom" : var.ssm_public_bucket_name_arn
          },
          {
            "name" : "DB_HOST",
            "valueFrom" : var.ssm_db_host_arn
          },
          {
            "name" : "DB_PORT",
            "valueFrom" : var.ssm_db_port_arn
          },
          {
            "name" : "DB_NAME",
            "valueFrom" : var.ssm_db_name_arn
          },
          {
            "name" : "DB_USER",
            "valueFrom" : var.ssm_db_user_arn
          },
          {
            "name" : "DB_PASSWORD",
            "valueFrom" : var.ssm_db_password_arn
          },
          {
            "name" : "NO_REPLY_EMAIL",
            "valueFrom" : var.ssm_no_reply_email_arn
          },
          {
            "name" : "EMPLOYER_URL",
            "valueFrom" : var.ssm_employer_url_arn
          },
          {
            "name" : "SENTRY_DSN",
            "valueFrom" : var.ssm_sentry_dsn_arn
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
