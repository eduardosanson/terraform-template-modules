resource "aws_lb" "cluster_lb" {
  name                       = "${var.cluster_name}-lb-${terraform.workspace}"
  internal                   = false
  load_balancer_type         = var.lb-type
  security_groups            = var.lb-type == "network" ? [] : [var.sg_id]
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

resource "aws_api_gateway_vpc_link" "vpc_link" {
  count       = var.vpc_lik ? 1 : 0
  name        = "${var.cluster_name}-vpc-link"
  description = "link to lb"
  target_arns = [aws_lb.cluster_lb.arn]
}