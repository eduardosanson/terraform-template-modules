resource "aws_lb_target_group" "target_group" {
  name     = "${var.target_group_name}-tg-${terraform.workspace}"
  port     = var.lb_port_redirect
  protocol = var.protocol != "" ? var.protocol : "HTTP"
  vpc_id   = var.vpc_id

  dynamic "health_check" {
    for_each = var.lb_type == "network" ? [
      {type:"interval", field: 60},
      {type:"port", field: 80},
      {type:"protocol", field:var.protocol},
      {type:"healthy_threshold", field:3},
      {type: "unhealthy_threshold", field: 3}
    ] :
    [
      {type:"path", field: var.health_check_path},
      {type:"interval", field: 10},
      {type:"timeout", field: 5},
      {type:"healthy_threshold", field: 3},
      {type:"unhealthy_threshold", field: 2},
      {type: "matcher", field: 200}
    ]
    content {
      type  = health_check.value.type
      field = health_check.value.field
    }
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

resource "aws_lb_listener_rule" "lb_listener_rules" {
  listener_arn = aws_lb_listener.lb_listener.arn
  priority     = 1

  action {
    target_group_arn = aws_lb_target_group.target_group.arn
    type             = "forward"
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}