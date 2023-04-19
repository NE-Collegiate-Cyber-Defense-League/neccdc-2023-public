resource "aws_instance" "windows_workstation" {
  ami           = data.aws_ami.windows_workstation_template.id
  instance_type = "t3a.large"
  subnet_id     = var.private_subnets[1]

  key_name             = var.blue_team_key_pair
  iam_instance_profile = var.ssm_role_name

  private_ip = "10.${var.team_number}.2.9"

  vpc_security_group_ids = [
    aws_security_group.security_group.id
  ]

  tags = {
    Name = "windows_workstation_${var.team_number}"
    OS   = "Server2019"
    Team = var.team_number
  }
}

data "aws_ami" "windows_workstation_template" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["win01-template-*"]
  }
}
