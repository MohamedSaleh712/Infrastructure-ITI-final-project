# --------------ElasticIP--------------#
resource "aws_eip" "ElasticIP" {
  depends_on = [
    aws_internet_gateway.igw
  ]
}

# --------------NAT--------------#
resource "aws_nat_gateway" "NAT-gateway" {
  for_each      = aws_subnet.public_subnets
  subnet_id     = each.value.id
  allocation_id = aws_eip.ElasticIP.allocation_id
}
