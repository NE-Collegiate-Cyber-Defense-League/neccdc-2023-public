data "aws_ami" "docker_swarm_rhel" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["packer-docker-swarm-rhel*"]
  }
}

resource "aws_instance" "swarm_manager" {
  ami           = data.aws_ami.docker_swarm_rhel.image_id
  instance_type = "t3.small"
  subnet_id     = var.private_subnets[0]

  key_name             = var.blue_team_key_pair
  iam_instance_profile = var.ssm_role_name

  private_ip = "10.${var.team_number}.0.4"


  user_data = templatefile("${path.module}/templates/swarm.sh", {
    team_number = var.team_number
    ec2_hostname = "swarm-manager"
  })

  vpc_security_group_ids = [
    aws_security_group.security_group.id
  ]

  tags = {
    OS   = "RHEL"
    Name = "swarm_manager_${var.team_number}"
    Team = var.team_number
  }
}

resource "aws_instance" "swarm_worker_1" {
  ami           = data.aws_ami.docker_swarm_rhel.image_id
  instance_type = "t2.small"
  subnet_id     = var.private_subnets[0]

  key_name             = var.blue_team_key_pair
  iam_instance_profile = var.ssm_role_name

  private_ip = "10.${var.team_number}.0.5"


  vpc_security_group_ids = [
    aws_security_group.security_group.id
  ]

  user_data = templatefile("${path.module}/templates/swarm.sh", {
    team_number = var.team_number
    ec2_hostname = "swarm-worker-1"
  })

  tags = {
    OS   = "RHEL"
    Name = "swarm_worker_1_${var.team_number}"
    Team = var.team_number
  }
}

resource "aws_instance" "swarm_worker_2" {
  ami           = data.aws_ami.docker_swarm_rhel.image_id
  instance_type = "t2.small"
  subnet_id     = var.private_subnets[0]

  key_name             = var.blue_team_key_pair
  iam_instance_profile = var.ssm_role_name

  private_ip = "10.${var.team_number}.0.6"


  vpc_security_group_ids = [
    aws_security_group.security_group.id
  ]

  user_data = templatefile("${path.module}/templates/swarm.sh", {
    team_number = var.team_number
    ec2_hostname = "swarm-worker-2"
  })

  tags = {
    OS   = "RHEL"
    Name = "swarm_worker_2_${var.team_number}"
    Team = var.team_number
  }
}

## Deb

data "aws_ami" "docker_swarm_deb" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["packer-docker-swarm-deb*"]
  }
}

resource "aws_instance" "swarm_worker_3" {
  ami           = data.aws_ami.docker_swarm_deb.image_id
  instance_type = "t2.small"
  subnet_id     = var.private_subnets[0]

  key_name             = var.blue_team_key_pair
  iam_instance_profile = var.ssm_role_name

  private_ip = "10.${var.team_number}.0.7"


  vpc_security_group_ids = [
    aws_security_group.security_group.id
  ]

  user_data = templatefile("${path.module}/templates/swarm.sh", {
    team_number = var.team_number
    ec2_hostname = "swarm-worker-3"
  })

  tags = {
    OS   = "debian"
    Name = "swarm_worker_3_${var.team_number}"
    Team = var.team_number
  }
}
