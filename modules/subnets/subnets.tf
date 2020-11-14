resource "aws_subnet" "public_subnets" {
  count             = length(var.public_cdirs)
  vpc_id            = var.vpc_id
  cidr_block        = var.public_cdirs[count.index]
  availability_zone = "${var.region}${var.azs[count.index]}"

  tags = {
    Name = "${var.subnets_prefix}${var.public_cdirs[count.index]}"
  }
}

resource "aws_route_table_association" "subnet_route_associations" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.rtbs_public[count.index].id
}

resource "aws_route_table" "rtbs_public" {
  count = length(aws_subnet.public_subnets)
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Environment = var.environment_tag
  }
}
