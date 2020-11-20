output "public_subnet" {
  value = aws_subnet.public_subnets.*.id
}

output "public_route_table" {
  value = aws_route_table.rtbs_public.*.id
}

output "private_subnet" {
  value = aws_subnet.private_subnets.*.id
}

output "private_route_table" {
  value = aws_route_table.rtbs_private.*.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat_gateway.*.id
}