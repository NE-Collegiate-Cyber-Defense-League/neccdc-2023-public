variable "team_number" {
  type = number
}

variable "vpc_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "private_route_table_ids" {
  type = list(string)
}
