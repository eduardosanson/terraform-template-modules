# -------------- Create a public subnet ------------------#

resource "aws_subnet" "public_subnets" {
  count             = length(var.public_cidrs)
  vpc_id            = var.vpc_id
  cidr_block        = var.public_cidrs[count.index]
  availability_zone = "${var.region}${var.azs[count.index]}"

  tags = {
    Name = "${var.subnets_prefix}${var.public_cdirs[count.index]}"
  }
}

resource "aws_route_table_association" "pub_subnet_rt_associations" {
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

# -------------- Create a private subnet ------------------#

resource "aws_subnet" "private_subnets" {
  count             = length(var.private_cidrs)
  vpc_id            = var.vpc_id
  cidr_block        = var.private_cidrs[count.index]
  availability_zone = "${var.region}${var.azs[count.index]}"

  tags = {
    Name = "${var.subnets_prefix}${var.private_cidrs[count.index]}"
  }
}

resource "aws_route_table" "rtbs_private" {
  count = length(aws_nat_gateway.nat_gateway)
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[count.index].id
  }
}

resource "aws_route_table_association" "private_subnet_rt_associations" {
  count           = length(aws_route_table.rtbs_private)
  subnet_id       = aws_subnet.private_subnets[count.index].id
  route_table_id  = aws_route_table.rtbs_private[count.index].id
}