resource "aws_iam_policy" "ecs_task_role_policy" {
  description = "Policies of ecs task"
  name        = "${var.prefix}-ecs-task-policy"
  path        = "/"

  policy = jsonencode(
    {
      "Statement" : [
        {
          "Action" : [
            "s3:PutObject",
          ],
          "Effect" : "Allow",
          "Resource" : "*",
          "Sid" : "VisualEditor0"
        }
      ],
      "Version" : "2012-10-17"
    }
  )
}

resource "aws_iam_policy" "ecs_task_execution_role_policy" {
  description = "Policies of ecs task execution"
  name        = "${var.prefix}-ecs-task-execution-policy"
  path        = "/"

  policy = jsonencode(
    {
      "Statement" : [
        {
          "Action" : [
            "logs:CreateLogGroup",
            "ssm:GetParameters",
          ],
          "Effect" : "Allow",
          "Resource" : "*",
          "Sid" : "VisualEditor0"
        }
      ],
      "Version" : "2012-10-17"
    }
  )
}

// policies for github actions
resource "aws_iam_policy" "github_actions_policy" {
  description = "Policies of github actions"
  name        = "${var.prefix}-github-actions-policy"
  path        = "/"

  policy = jsonencode(
    {
      "Statement" : [
        {
          "Action" : [
            "codedeploy:CreateDeployment",
            "codedeploy:GetDeployment",
            "codedeploy:GetDeploymentConfig",
            "codedeploy:GetDeploymentGroup",
            "codedeploy:RegisterApplicationRevision",
            "ecs:DescribeServices",
            "ecs:DescribeServices",
            "ecs:DescribeTaskDefinition",
            "ecs:DescribeTasks",
            "ecs:ListClusters",
            "ecs:ListServices",
            "ecs:RegisterTaskDefinition",
            "ecs:UpdateService",
            "iam:PassRole"
          ],
          "Effect" : "Allow",
          "Resource" : "*",
          "Sid" : "VisualEditor0"
        }
      ],
      "Version" : "2012-10-17"
    }
  )
}
