resource "aws_instance" "wazuh" {
  ami           = "ami-0aef9460ec9c0b2d6"
  instance_type = "t3a.medium"
  subnet_id     = var.private_subnets[1]

  key_name             = var.blue_team_key_pair
  iam_instance_profile = var.ssm_role_name

  private_ip = "10.${var.team_number}.2.7"

  vpc_security_group_ids = [
    aws_security_group.security_group.id
  ]

  tags = {
    OS      = "Amazon"
    Name    = "wazuh_${var.team_number}"
    Team    = var.team_number
    Service = "Wazuh"
  }
}
