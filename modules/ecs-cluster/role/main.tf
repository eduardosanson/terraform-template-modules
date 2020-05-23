resource "aws_iam_instance_profile" "ecs-instance-profile" {
  name = "${var.cluster_name}-ecs-instance-profile-${terraform.workspace}"
  path = "/"
  role = aws_iam_role.ecs-instance-role.id
}

resource "aws_iam_role" "ecs-instance-role" {
  name               = "${var.cluster_name}-ecs-instance-role-${terraform.workspace}"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ec2-policy.json
}

resource "aws_iam_role_policy_attachment" "ecs-instance-role-attachment" {
  role       = aws_iam_role.ecs-instance-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}
