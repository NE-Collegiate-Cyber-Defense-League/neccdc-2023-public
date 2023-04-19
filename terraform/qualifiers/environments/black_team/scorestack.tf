resource "aws_security_group" "black_internal" {
  name        = "black-internal-sg"
  description = "Internal Network Access"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "172.16.0.0/12",
      "10.0.0.0/8",
      "192.168.0.0/16"
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
    Name = "black-internal-sg"
  }
}

resource "aws_instance" "scorestack" {
  ami           = data.aws_ami.scorestack.id
  instance_type = "t3.large"
  key_name      = "black-team"
  subnet_id     = module.vpc.public_subnets[0]

  vpc_security_group_ids = [
    aws_security_group.black_internal.id
  ]

  tags = {
    Name = "scorestack"
  }
}

data "aws_ami" "scorestack" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["scorestack-*"]
  }
}
