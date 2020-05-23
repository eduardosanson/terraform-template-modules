resource "aws_lb_target_group" "target_group" {
  name     = "${var.container_name}-tg-${terraform.workspace}"
  port     = var.lb_port_redirect
  protocol = var.protocol != "" ? var.protocol : "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = var.health_check_path
    interval            = 10
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
    matcher             = 200
  }

  lifecycle {
    create_before_destroy = true
  }
}