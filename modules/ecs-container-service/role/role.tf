resource "aws_iam_role" "ecs-execution-role" {
  name               = "${var.cluster_name}-${var.app-name}-ecs-execution-role-${terraform.workspace}"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ecs-tasks-policy.json
}

resource "aws_iam_role_policy_attachment" "ecs-execution-role-attachment" {
  role       = aws_iam_role.ecs-execution-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "ecs-service-role" {
  name               = "${var.cluster_name}-${var.app-name}-ecs-service-role-${terraform.workspace}"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ecs-policy.json
}

resource "aws_iam_role_policy_attachment" "ecs-service-role-attachment" {
  role       = aws_iam_role.ecs-service-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}