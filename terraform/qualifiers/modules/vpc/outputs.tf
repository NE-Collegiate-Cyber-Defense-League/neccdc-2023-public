output "azs" {
  value = module.vpc.azs
}

output "private_subnet_arns" {
  value = module.vpc.private_subnet_arns
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "private_subnets_cidr_blocks" {
  value = module.vpc.private_subnets_cidr_blocks
}

output "public_subnet_arns" {
  value = module.vpc.public_subnet_arns
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "vpc_public_subnets_cidr_blocks" {
  value = module.vpc.public_subnets_cidr_blocks
}

output "vpc_arn" {
  value = module.vpc.vpc_arn
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_route_table_ids" {
  value = module.vpc.private_route_table_ids
}
