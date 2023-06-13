
#--------------Public subnets--------------#
resource "aws_subnet" "public_subnets" {
  vpc_id                  = aws_vpc.vpc.id
  for_each                = var.public_subnets_vars
  cidr_block              = each.value[0]
  availability_zone       = each.value[1]
  map_public_ip_on_launch = true
  tags = {
    Name                                          = each.key
    "kubernetes.io/cluster/eks-iti-final-project" = "shared"
    "kubernetes.io/role/elb"                      = 1
  }
}

#--------------Private subnets--------------#
resource "aws_subnet" "private_subnets" {
  vpc_id            = aws_vpc.vpc.id
  for_each          = var.private_subnets_vars
  cidr_block        = each.value[0]
  availability_zone = each.value[1]
  tags = {
    Name                                          = each.key
    "kubernetes.io/cluster/eks-iti-final-project" = "shared"
    "kubernetes.io/role/internal-elb"             = 1
  }
}