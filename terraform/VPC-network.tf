#--------------vpc--------------#
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support   = true #Required for EKS to run, default is true
  enable_dns_hostnames = true #Required for EKS to run, default is false
  tags = {
    Name = var.vpc_name
  }
}

#--------------IGW--------------#
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = var.igw_name
  }
}
