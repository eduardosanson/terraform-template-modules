resource "aws_ecs_cluster" "ecs-clusters" {
  name = var.cluster_name
}