output "public_subnet" {
  value = aws_subnet.public_subnets.*.id
}

output "public_route_table" {
  value = aws_route_table.rtbs_public.*.id
}