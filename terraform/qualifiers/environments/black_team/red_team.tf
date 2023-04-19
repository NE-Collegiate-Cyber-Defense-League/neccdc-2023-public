variable "red_interface_count" {
  type    = number
  default = 50
}

resource "aws_security_group" "red_team" {
  name        = "read-team-sg"
  description = "Read Team Network Access"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "read-team-sg"
  }
}

data "aws_ami" "red_team" {
  most_recent = true
  
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20230112"]
  }
}

resource "aws_instance" "red_team" {
  ami           = data.aws_ami.red_team.id
  instance_type = "t3.large"

  iam_instance_profile = "SSM"

  key_name = "red-team"

  dynamic "network_interface" {
    for_each = range(var.red_interface_count)

    content {
      device_index         = network_interface.value
      network_interface_id = aws_network_interface.red_team_interface[network_interface.value].id
    }
  }

  tags = {
    "Name" = "red-team"
  }
}

resource "aws_network_interface" "red_team_interface" {
  count = var.red_interface_count

  private_ips_count = count.index * 4

  subnet_id = module.vpc.public_subnets[0]

  security_groups = [
    aws_security_group.black_internal.id,
    aws_security_group.red_team.id
  ]

  tags = {
    "Name" = "red-team"
  }
}

resource "aws_eip" "red_team_public_ip" {
  vpc = true

  tags = {
    Name = "red_team_public_eip"
  }
}

resource "aws_eip_association" "red_team_public_ip_association" {
  network_interface_id = aws_network_interface.red_team_interface[0].id
  allocation_id        = aws_eip.red_team_public_ip.id
}
