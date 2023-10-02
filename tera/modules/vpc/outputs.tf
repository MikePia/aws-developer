# modules/vpc/outputs.tf
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr" {
  value = module.vpc.vpc_cidr_block
}

output "public_subnets" {
  value = module.vpc.public_subnets[0]
}

# output "private_subnets" {
#   value = module.vpc.private_subnets
# }  