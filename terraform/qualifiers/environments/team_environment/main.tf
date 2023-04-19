locals {
  number_of_teams = 1
  addition        = 1 # Set to 1 for first team
}

module "vpc" {
  source = "../../modules/vpc"
  count  = local.number_of_teams

  team_number = count.index + local.addition
  vpc_cidr    = "10.${count.index + local.addition}.0.0/16"
}


module "ec2" {
  count  = local.number_of_teams
  source = "../../modules/ec2"

  team_number = count.index + local.addition

  vpc_id          = module.vpc[count.index].vpc_id
  private_subnets = module.vpc[count.index].private_subnets
}

module "transit_gateway_attachment" {
  count  = local.number_of_teams
  source = "../../modules/transit_gateway_attachment"

  depends_on = [
    module.ec2
  ]

  team_number = count.index + local.addition

  vpc_id          = module.vpc[count.index].vpc_id
  private_subnets = module.vpc[count.index].private_subnets
  private_route_table_ids = module.vpc[count.index].private_route_table_ids
}
