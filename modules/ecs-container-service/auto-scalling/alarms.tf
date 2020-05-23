resource "aws_cloudwatch_metric_alarm" "cloudwatch-metrics-memory-utilization-scale-up-alarm" {
  alarm_name                = "${aws_appautoscaling_policy.aws_appautoscaling_up_memory_policie.service_namespace}-memory-utilization-scale-up-${terraform.workspace}"
  alarm_actions             = [aws_appautoscaling_policy.aws_appautoscaling_up_memory_policie.arn]
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 10
  metric_name               = "MemoryUtilization"
  namespace                 = "AWS/ECS"
  period                    = 180
  statistic                 = "Average"
  threshold                 = 70
  alarm_description         = "Alarme para utilização de memória de uma instância docker no ambiente de ${terraform.workspace}"
  dimensions                = {
    ClusterName = var.cluster_name
    ServiceName = aws_appautoscaling_policy.aws_appautoscaling_up_memory_policie.name
  }
}

resource "aws_cloudwatch_metric_alarm" "cloudwatch-metrics-memory-utilization-scale-down-alarm" {
  alarm_name                = "${aws_appautoscaling_policy.aws_appautoscaling_down_memory_policie.service_namespace}-memory-utilization-scale-down-${terraform.workspace}"
  alarm_actions             = [ aws_appautoscaling_policy.aws_appautoscaling_down_memory_policie.arn ]
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = 10
  metric_name               = "MemoryUtilization"
  namespace                 = "AWS/ECS"
  period                    = 180
  statistic                 = "Average"
  threshold                 = 30
  alarm_description         = "Alarme para utilização de memória de uma instância docker no ambiente de ${terraform.workspace}"
  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = aws_appautoscaling_policy.aws_appautoscaling_down_memory_policie.name
  }
}
