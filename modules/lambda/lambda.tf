resource "aws_lambda_function" "update_application_statuses" {
  function_name    = "${var.prefix}-update-application-statuses"
  role             = var.lambda_role_arn
  runtime          = "nodejs18.x"
  handler          = "update-application-statuses.handler"
  filename         = "../../modules/lambda/update-application-statuses.zip"
  source_code_hash = filebase64sha256("../../modules/lambda/update-application-statuses.zip")

  environment {
    variables = {
      SCHEDULER_SECRET_TOKEN = var.scheduler_secret_token
      API_BASE_URL           = var.api_base_url
    }
  }
}
