output "security_groups" {
  value = aws_launch_configuration.ec2_for_ecs.security_groups
}

output "launch_configuration_id" {
  value = aws_launch_configuration.ec2_for_ecs.id
}
