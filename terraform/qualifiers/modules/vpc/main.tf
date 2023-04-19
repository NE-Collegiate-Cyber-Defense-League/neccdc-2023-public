locals {
  subnet_cidr = cidrsubnets(var.vpc_cidr, 8, 7)
}

# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.16.0"

  name = "vpc_${var.team_number}"
  cidr = var.vpc_cidr

  azs             = ["us-east-2a", "us-east-2b"]
  private_subnets = local.subnet_cidr
  public_subnets  = []

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway     = false
  single_nat_gateway     = false
  one_nat_gateway_per_az = false

  tags = {
    TeamNumber = var.team_number
  }
}
