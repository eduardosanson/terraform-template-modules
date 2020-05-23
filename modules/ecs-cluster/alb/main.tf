resource "aws_lb" "cluster_alb" {
  name                       = "${var.cluster_name}-lb-${terraform.workspace}"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.sg_id]
  subnets                    = var.vpc_subnets
  enable_deletion_protection = false

  access_logs {
    bucket  = "${var.cluster_name}-lb-logs-${terraform.workspace}"
    enabled = false
  }

  tags = {
    Environment = terraform.workspace
  }
}