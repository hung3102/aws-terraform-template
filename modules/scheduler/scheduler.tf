resource "aws_scheduler_schedule" "call_update_application_statuses" {
  name       = "${var.prefix}-update-application-statuses"
  group_name = "default"
  flexible_time_window {
    mode = "OFF"
  }

  // run at 00:00 JST every day
  schedule_expression = "cron(0 15 * * ? *)" # UTC time equivalent to 00:00 JST

  target {
    arn      = var.update_application_statuses_lambda_arn
    role_arn = var.lambda_role_arn
  }
}
