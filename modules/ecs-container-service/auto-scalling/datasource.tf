data "aws_iam_role" "ecs_autoscale_service_linked_role" {
  name = "AWSServiceRoleForApplicationAutoScaling_ECSService"
}
