resource "aws_iam_role" "ecs_taskexexecution_role" {
  name = var.taskexecution_role_name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = var.assume_role_policy_action
        Effect = var.assume_role_policy_effect
        Principal = {
          Service = var.assume_role_policy_principal_service
        }
      },
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "taskexexcution_attach" {
  role       = aws_iam_role.ecs_taskexexecution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
