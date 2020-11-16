resource "aws_lb_target_group" "target_group" {
  name     = "${var.target_group_name}-nlb-${terraform.workspace}"
  port     = var.lb_port_redirect
  protocol = var.protocol != "" ? var.protocol : "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    protocol            = var.protocol
    interval            = 10
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = var.load_balancer_arn
  port              = var.lb_port_redirect
  protocol          = var.protocol != "" ? var.protocol : "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.target_group.arn
    type             = "forward"
  }
}
