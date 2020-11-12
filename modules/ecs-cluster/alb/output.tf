output "alb_arn" {
  value = aws_lb.cluster_alb.arn
}

output "alb_dns" {
  value = aws_lb.cluster_alb.dns_name
}