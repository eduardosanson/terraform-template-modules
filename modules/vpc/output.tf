output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "ig_id" {
   value = aws_internet_gateway.igw.id
 }
