output "ecs-execution-role-arn" {
  value = aws_iam_role.ecs-execution-role.arn
}

output "ecs-execution-role-name" {
  value = aws_iam_role.ecs-execution-role.name
}

output "ecs-service-role-arn" {
  value = aws_iam_role.ecs-service-role.arn
}

output "ecs-service-role-name" {
  value = aws_iam_role.ecs-service-role.name
}