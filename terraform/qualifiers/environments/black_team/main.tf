# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.16.0"

  name = "vpc_admin"
  cidr = "172.16.0.0/16"

  azs             = ["us-east-2a"]
  private_subnets = ["172.16.0.0/20"]
  public_subnets  = ["172.16.128.0/20"]

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
}

resource "aws_ec2_transit_gateway" "challenge_gate" {
  description = "example"
  tags = {
    Name = "challenge-gate"
  }
}

resource "aws_ec2_transit_gateway_route" "internet_route" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.challange_attachement.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway.challenge_gate.association_default_route_table_id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "challange_attachement" {
  subnet_ids         = module.vpc.private_subnets
  transit_gateway_id = aws_ec2_transit_gateway.challenge_gate.id
  vpc_id             = module.vpc.vpc_id
  tags = {
    Name = "admin"
  }
}

resource "aws_route" "private_subnet" {
  route_table_id         = module.vpc.private_route_table_ids[0]
  destination_cidr_block = "10.0.0.0/8"
  transit_gateway_id     = aws_ec2_transit_gateway.challenge_gate.id
}

resource "aws_route" "public_subnet" {
  route_table_id         = module.vpc.public_route_table_ids[0]
  destination_cidr_block = "10.0.0.0/8"
  transit_gateway_id     = aws_ec2_transit_gateway.challenge_gate.id
}
