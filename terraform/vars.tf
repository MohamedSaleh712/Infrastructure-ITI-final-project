variable "region" {
  type    = string
  default = "us-east-1"
}

variable "profile" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "igw_name" {
  type = string
}

variable "nat_name" {
  type = string
}