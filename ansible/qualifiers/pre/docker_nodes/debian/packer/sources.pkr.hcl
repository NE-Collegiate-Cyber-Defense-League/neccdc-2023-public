source "amazon-ebs" "vm" {
  region            = "us-east-2"
  subnet_id         = "subnet-06a7a4a5cd34e2e75"
  security_group_id = "sg-08d59db1e3df8fe8a"
  ami_name          = "packer-docker-swarm-debian-${formatdate("YYYY-MMM-DD-hh-mm", timestamp())}"

  source_ami                  = "ami-0b3e2bb9a70a08ad3" # Debian 11 (20221205-1220)
  instance_type               = "t3.small"

  associate_public_ip_address = false

  tags = {
    "Name" = "docker-swarm-debian"
    "Date" = formatdate("YYYY-MM-DD hh:mm", timestamp())
  }
  run_tags = {
    "Name" = "Packer-temporary-build-server"
  }
}
