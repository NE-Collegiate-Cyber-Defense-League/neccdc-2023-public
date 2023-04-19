resource "aws_security_group" "security_group" {
  name        = "security_group_${var.team_number}"
  description = "Allow traffic for the team"
  vpc_id      = var.vpc_id

  ingress {
    description = "All traffic from teams vpc"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.${var.team_number}.0.0/16"]
  }

  ingress {
    description = "All traffic from black team vpc"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["172.16.0.0/16"]
  }

  ingress {
    description = "Another black team vpc"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["172.30.0.0/16"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "security_group_${var.team_number}"
    Team = var.team_number
  }
}
