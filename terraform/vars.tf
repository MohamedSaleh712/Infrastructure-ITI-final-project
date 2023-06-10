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

variable "public_subnets_vars" {
  type = map(tuple([string, string]))
}

variable "private_subnets_vars" {
  type = map(tuple([string, string]))
}

variable "nat_name" {
  type = list(string)
}

variable "default_route" {
  type = string
}

variable "public_route_table_name" {
  type = string
}

variable "private_route_table_name" {
   type = list(string)
}
# variable "route_ids" {

# }

# variable "subnet_id_count" {

# }