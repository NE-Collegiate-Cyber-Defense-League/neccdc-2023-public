resource "aws_security_group" "wireguard_sg" {
  name        = "wireguard-sg"
  description = "Allow WG from Any"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 51820
    to_port     = 51820
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Public SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "wireguard-sg"
  }
}

resource "aws_eip" "wireguard_public_ip" {
  vpc = true

  tags = {
    Name = "wireguard_public_eip"
  }
}

resource "aws_eip_association" "wireguard_eip" {
  instance_id   = aws_instance.wireguard.id
  allocation_id = aws_eip.wireguard_public_ip.id
}

resource "aws_instance" "wireguard" {
  ami           = data.aws_ami.wireguard.id
  instance_type = "t3.large"

  iam_instance_profile = "SSM"

  subnet_id = module.vpc.public_subnets[0]

  key_name = "team-public-box"

  associate_public_ip_address = true

  vpc_security_group_ids = [
    aws_security_group.wireguard_sg.id,
    aws_security_group.black_internal.id
  ]

  tags = {
    "Name" = "wireguard"
  }
}

data "aws_ami" "wireguard" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["wireguard-*"]
  }
}

