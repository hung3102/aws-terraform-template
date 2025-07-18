output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_task_role_arn" {
  value = aws_iam_role.ecs_task_role.arn
}

output "codedeploy_role_arn" {
  value = aws_iam_role.codedeploy_role.arn
}

output "bastion_host_role_name" {
  value = aws_iam_role.bastion_host_role.name
}

output "lambda_role_arn" {
  value = aws_iam_role.lambda_role.arn
}
