#--------------Public Route Table--------------#
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.default_route
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.public_route_table_name
  }
}

#--------------Public Route Table Association--------------#
resource "aws_route_table_association" "public_route_table_association" {
  for_each       = aws_subnet.public_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_route_table.id
}



#--------------Private Route Tables--------------#
resource "aws_route_table" "private_route_table_1" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = var.default_route
    nat_gateway_id = aws_nat_gateway.NAT_gateway_1.id
  }
  tags = {
    Name = var.private_route_table_name[0]
  }
}

resource "aws_route_table" "private_route_table_2" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = var.default_route
    nat_gateway_id = aws_nat_gateway.NAT_gateway_2.id
  }
  tags = {
    Name = var.private_route_table_name[1]
  }
}

#--------------Private Route Table Association--------------#
# resource "aws_route_table_association" "private_route_table_association" {
#   for_each  = aws_subnet.private_subnets
#   subnet_id = each.value.id
#   subnet_id_count = length(var.subnet_ids)
#   subnet_id       = var.subnet_ids[subnet_id_count.index].id

#   route_table_id_count = length(var.route_ids)
#   route_table_id       = var.route_ids[route_table_id_count.index]
# }

resource "aws_route_table_association" "private_route_table_association_1" {
  subnet_id      = aws_subnet.private_subnets["private_subnet_1"].id
  route_table_id = aws_route_table.private_route_table_1.id
}

resource "aws_route_table_association" "private_route_table_association_2" {
  subnet_id      = aws_subnet.private_subnets["private_subnet_2"].id
  route_table_id = aws_route_table.private_route_table_2.id
}