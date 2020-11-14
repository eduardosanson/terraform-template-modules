resource "aws_lb" "load_balancer" {
  name                       = "${var.lb-name}-${var.lb-type}-${terraform.workspace}"
  internal                   = false
  load_balancer_type         = var.lb-type
  security_groups            = var.lb-type == "network" ? [] : [var.sg_id]
  subnets                    = var.vpc_subnets
  enable_deletion_protection = false

  access_logs {
    bucket  = "${var.lb-name}-lb-logs-${terraform.workspace}"
    enabled = false
  }

  tags = {
    Environment = terraform.workspace
  }
}

