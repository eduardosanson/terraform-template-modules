resource "aws_cloudwatch_metric_alarm" "cluster-memory-reservation-alarms-down" {
  alarm_name                = "${var.cluster_name}-memory-reservation-alarm-down-${terraform.workspace}"
  alarm_actions             = ["${aws_autoscaling_policy.ec2_auto_scaling_policy_down[0].arn}"]
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = 4
  metric_name               = "MemoryReservation"
  namespace                 = "AWS/ECS"
  period                    = 120
  statistic                 = "Average"
  threshold                 = 50
  alarm_description         = "Alarme para reserva de memória das instâncias do cluster ${var.cluster_name}-${terraform.workspace}"
  dimensions                = {
    ClusterName = "${var.cluster_name}-${terraform.workspace}"
  }
}

resource "aws_cloudwatch_metric_alarm" "cluster-memory-reservation-alarms-up" {
  alarm_name                = "cluster-memory-reservation-alarm-up-${terraform.workspace}"
  alarm_actions             = ["${aws_autoscaling_policy.ec2_auto_scaling_policy_up[0].arn}"]
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "MemoryReservation"
  namespace                 = "AWS/ECS"
  period                    = 120
  statistic                 = "Average"
  threshold                 = 70
  alarm_description         = "Alarme para reserva de memória das instâncias do cluster ${var.cluster_name}-${terraform.workspace}"
  dimensions                = {
    ClusterName = "${var.cluster_name}-${terraform.workspace}"
  }
}
