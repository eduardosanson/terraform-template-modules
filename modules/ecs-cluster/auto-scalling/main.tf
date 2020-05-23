resource "aws_autoscaling_group" "ecs_asg" {
  name                      = "autoscaling-${var.cluster_name}-${terraform.workspace}"
  launch_configuration      = var.launch_configuration_id
  min_size                  = var.cluster_min_size
  max_size                  = var.cluster_max_size
  health_check_grace_period = 150
  default_cooldown          = 180
  termination_policies      = ["NewestInstance"]
  lifecycle {
    create_before_destroy = true
  }
  vpc_zone_identifier       = var.subnet_ids
  tag {
    key                 = "Name"
    value               = "terraform-ecs-autoscaling-${terraform.workspace}"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_schedule" "scheduled_auto_scale_out" {
  count                  = terraform.workspace != "prod" ? 1 : 0
  scheduled_action_name  = "autoscaling_schedule-out-${var.cluster_name}-${terraform.workspace}"
  recurrence             = "0 1 * * 1-5"
  min_size               = 0
  max_size               = 0
  desired_capacity       = 0
  autoscaling_group_name = aws_autoscaling_group.ecs_asg.name
}

resource "aws_autoscaling_schedule" "scheduled_auto_scale_in" {
  count                  = terraform.workspace != "prod" ? 1 : 0
  scheduled_action_name  = "autoscaling_schedule-in-${var.cluster_name}-${terraform.workspace}"
  min_size               = var.cluster_min_size
  max_size               = var.cluster_max_size
  desired_capacity       = var.cluster_min_size
  recurrence             = "0 11 * * 1-5"
  autoscaling_group_name = aws_autoscaling_group.ecs_asg.name
}

resource "aws_autoscaling_policy" "ec2_auto_scaling_policy_up" {
  count = 2
  name  = "${count.index == 1 ? "ec2_auto_scaling_policy_cpu_up" : "ec2_auto_scaling_policy_memory_up"}_${terraform.workspace}"

  policy_type               = "StepScaling"
  autoscaling_group_name    = aws_autoscaling_group.ecs_asg.name
  adjustment_type           = "ChangeInCapacity"
  estimated_instance_warmup = 300

  ###### SCALE UP #####

  step_adjustment {
    metric_interval_upper_bound = 10
    metric_interval_lower_bound = 0
    scaling_adjustment          = 1
  }

  step_adjustment {
    metric_interval_upper_bound = 20
    metric_interval_lower_bound = 10
    scaling_adjustment          = 1
  }

  step_adjustment {
    metric_interval_lower_bound = 20
    scaling_adjustment          = 1
  }
}


resource "aws_autoscaling_policy" "ec2_auto_scaling_policy_down" {
  count = 2
  name  = "${count.index == 1 ? "ec2_auto_scaling_policy_cpu_down" : "ec2_auto_scaling_policy_memory_down"}_${terraform.workspace}"

  policy_type               = "StepScaling"
  autoscaling_group_name    = aws_autoscaling_group.ecs_asg.name
  adjustment_type           = "ChangeInCapacity"
  estimated_instance_warmup = 300

  ###### SCALE DOWN #####

  step_adjustment {
    metric_interval_upper_bound = 0
    metric_interval_lower_bound = -10
    scaling_adjustment          = -1
  }

  step_adjustment {
    metric_interval_upper_bound = -10
    metric_interval_lower_bound = -20
    scaling_adjustment          = -1
  }

  step_adjustment {
    metric_interval_upper_bound = -20
    scaling_adjustment          = -1
  }
}
