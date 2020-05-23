output "ecs-instance-profile-arn" {
  value = aws_iam_instance_profile.ecs-instance-profile.arn
}

output "ecs-instance-profiel-role-name" {
  value = aws_iam_role.ecs-instance-role.name
}
