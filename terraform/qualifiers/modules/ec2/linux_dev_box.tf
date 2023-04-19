resource "aws_instance" "linux_dev_box" {
  ami           = data.aws_ami.linux_dev_box.id
  instance_type = "t3.small"
  subnet_id     = var.private_subnets[1]

  key_name             = var.blue_team_key_pair
  iam_instance_profile = var.ssm_role_name

  private_ip = "10.${var.team_number}.2.8"

  vpc_security_group_ids = [
    aws_security_group.security_group.id
  ]

  tags = {
    OS   = "Ubuntu"
    Name = "linux_dev_box_${var.team_number}"
    Team = var.team_number
  }
}

data "aws_ami" "linux_dev_box" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["packer-linux-dev-box-*"]
  }
}
