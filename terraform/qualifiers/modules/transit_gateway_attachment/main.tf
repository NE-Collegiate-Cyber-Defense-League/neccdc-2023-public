resource "aws_ec2_transit_gateway_vpc_attachment" "team_attachment" {
  subnet_ids         = var.private_subnets
  transit_gateway_id = data.aws_ec2_transit_gateway.challenge_gate.id
  vpc_id             = var.vpc_id

  tags = {
    Name = var.team_number
  }
}

data "aws_ec2_transit_gateway" "challenge_gate" {
  filter {
    name   = "tag:Name"
    values = ["challenge-gate"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_route" "subnet_zero_int" {
  route_table_id         = var.private_route_table_ids[0]
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = data.aws_ec2_transit_gateway.challenge_gate.id
}

resource "aws_route" "subnet_zero_proxy" {
  route_table_id         = var.private_route_table_ids[0]
  destination_cidr_block = "172.16.0.0/16"
  transit_gateway_id     = data.aws_ec2_transit_gateway.challenge_gate.id
}

resource "aws_route" "subnet_one_int" {
  route_table_id         = var.private_route_table_ids[1]
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = data.aws_ec2_transit_gateway.challenge_gate.id
}

resource "aws_route" "subnet_one_proxy" {
  route_table_id         = var.private_route_table_ids[1]
  destination_cidr_block = "172.16.0.0/16"
  transit_gateway_id     = data.aws_ec2_transit_gateway.challenge_gate.id
}
