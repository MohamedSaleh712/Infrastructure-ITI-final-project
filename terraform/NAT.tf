# --------------ElasticIP--------------#
resource "aws_eip" "ElasticIP_1" {
  depends_on = [
    aws_internet_gateway.igw
  ]
}

resource "aws_eip" "ElasticIP_2" {
  depends_on = [
    aws_internet_gateway.igw
  ]
}

# --------------NAT--------------#
# resource "aws_nat_gateway" "NAT-gateway" {
#   for_each      = aws_subnet.public_subnets
#   subnet_id     = each.value.id
#   allocation_id = aws_eip.ElasticIP.allocation_id
# }

resource "aws_nat_gateway" "NAT_gateway_1" {
  subnet_id     = aws_subnet.public_subnets["public_subnet_1"].id
  allocation_id = aws_eip.ElasticIP_1.allocation_id
  tags = {
    Name= var.nat_name[0]
  }
}

resource "aws_nat_gateway" "NAT_gateway_2" {
  subnet_id     = aws_subnet.public_subnets["public_subnet_1"].id
  allocation_id = aws_eip.ElasticIP_2.allocation_id
    tags = {
    Name= var.nat_name[1]
  }
}