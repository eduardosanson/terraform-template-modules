output "lb_arn" {
  value = aws_lb.cluster_lb.arn
}

output "lb_dns" {
  value = aws_lb.cluster_lb.dns_name
}

output "lb_port" {
  value = aws_lb.cluster_lb.dns_name
}

output "vpc_link" {
  value = aws_api_gateway_vpc_link.vpc_link.id
}