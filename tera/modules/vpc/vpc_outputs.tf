# modules/vpc/outputs.tf
output "vpc_id" {
  value = aws_vpc.tutcert_vpc.id
}

output "vpc_cidr" {
  # value = module.vpc.vpc_cidr_block
  value = aws_vpc.tutcert_vpc.cidr_block
}

# output "public_subnets" {
#   # value = aws_vpc.tut
#   value = aws_subnet.tutcert_public_subnet_1.id
# }
output "public_subnet1_id" {
  value = aws_subnet.tutcert_public_subnet_1.id
}

output "data_subnet1_id" {
  value = aws_subnet.tutcert_private_data_subnet1.id
}

output "data_subnet2_id" {
  value = aws_subnet.tutcert_private_data_subnet2.id
}

# output "private_subnets" {
#   value = module.vpc.private_subnets
# }  