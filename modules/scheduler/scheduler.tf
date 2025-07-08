resource "aws_scheduler_schedule" "call_update_application_statuses" {
  name       = "${var.prefix}-update-application-statuses"
  group_name = "default"
  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = "rate(1 day)" # or cron(...) for more specific times

  target {
    arn      = var.update_application_statuses_lambda_arn
    role_arn = var.lambda_role_arn
  }
}
