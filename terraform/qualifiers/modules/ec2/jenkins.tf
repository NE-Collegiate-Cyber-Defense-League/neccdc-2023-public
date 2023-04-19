resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.jenkins.image_id
  instance_type = "t3a.medium"
  subnet_id     = var.private_subnets[1]

  key_name             = var.blue_team_key_pair
  iam_instance_profile = var.ssm_role_name

  private_ip = "10.${var.team_number}.2.6"

  user_data = templatefile("${path.module}/templates/jenkins_init.sh", {
    team_number = var.team_number
  })

  vpc_security_group_ids = [
    aws_security_group.security_group.id
  ]

  tags = {
    OS   = "Debian"
    Name = "jenkins_${var.team_number}"
    Team = var.team_number
  }
}

data "aws_ami" "jenkins" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["packer-jenkins-*"]
  }
}
