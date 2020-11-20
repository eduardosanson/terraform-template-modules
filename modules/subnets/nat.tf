resource "aws_eip" "nat_gateway" {
  count = var.enable_nat ? length(aws_subnet.public_subnets) : 0
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  count = length(aws_subnet.public_subnets)
  allocation_id = aws_eip.nat_gateway[count.index].id
  subnet_id = aws_subnet.public_subnets[count.index].id
  tags = {
    "Name" = "Nat gateway"
  }
}