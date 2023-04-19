variable "team_number" {
  type = number
}

variable "vpc_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "ssm_role_name" {
  type    = string
  default = "SSM"
}

variable "blue_team_key_pair" {
  type    = string
  default = "blue-team"
}
