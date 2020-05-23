resource "aws_appautoscaling_target" "appautoscaling_target" {
  max_capacity       = var.max_capacity
  min_capacity       = var.min_capacity
  resource_id        = "service/${var.cluster_name}/${var.service_name}"
  role_arn           = data.aws_iam_role.ecs_autoscale_service_linked_role.arn
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "aws_appautoscaling_up_memory_policie" {
  name               = "${aws_appautoscaling_target.appautoscaling_target.service_namespace}-memory-scale-up-${terraform.workspace}"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.appautoscaling_target.resource_id
  scalable_dimension = aws_appautoscaling_target.appautoscaling_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.appautoscaling_target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    ###### SCALE UP #####

    step_adjustment {
      metric_interval_lower_bound = 0
      metric_interval_upper_bound = 10
      scaling_adjustment          = 1
    }

    step_adjustment {
      metric_interval_lower_bound = 10
      metric_interval_upper_bound = 20
      scaling_adjustment          = 1
    }

    step_adjustment {
      metric_interval_lower_bound = 20
      scaling_adjustment          = 1
    }
  }
}

resource "aws_appautoscaling_policy" "aws_appautoscaling_down_memory_policie" {
  name               = "${aws_appautoscaling_target.appautoscaling_target.service_namespace}-memory-scale-down-${terraform.workspace}"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.appautoscaling_target.resource_id
  scalable_dimension = aws_appautoscaling_target.appautoscaling_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.appautoscaling_target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    ###### SCALE DOWN #####

    step_adjustment {
      metric_interval_upper_bound = -10
      metric_interval_lower_bound = -20
      scaling_adjustment          = -1
    }

    step_adjustment {
      metric_interval_upper_bound = -20
      scaling_adjustment          = -1
    }

    step_adjustment {
      metric_interval_upper_bound = 0
      metric_interval_lower_bound = -10
      scaling_adjustment          = -1
    }
  }
}
