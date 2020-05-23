data "template_file" "task_definitions_template" {
  template = file(var.task_defination_path)
  vars     = {
    env                   = terraform.workspace
    name                  = var.container_name
    image                 = var.container_image
    port                  = var.lb_port_redirect
  }
}

resource "aws_ecs_task_definition" "tasks_definitions" {
  family                   = var.container_name
  requires_compatibilities = ["EC2"]
  container_definitions    = data.template_file.task_definitions_template.rendered
  network_mode             = "bridge"
  execution_role_arn       = var.role_execution_arn
}

resource "aws_ecs_service" "ecs_services" {
  name                              = var.container_name
  cluster                           = var.ecs_cluster_id
  task_definition                   = aws_ecs_task_definition.tasks_definitions.arn
  iam_role                          = var.role_service_arn
  health_check_grace_period_seconds = 120
  scheduling_strategy               = "REPLICA"
  desired_count                     = 1

  ordered_placement_strategy {
    type = "spread"
    field = "attribute:ecs.availability-zone"
  }

  ordered_placement_strategy {
    type = "binpack"
    field = "memory"
  }

  load_balancer {
    target_group_arn = var.lb_target_group_arn
    container_name   = var.container_name
    container_port   = var.lb_port_redirect
  }
}
