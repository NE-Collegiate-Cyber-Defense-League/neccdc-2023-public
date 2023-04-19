# https://www.packer.io/plugins/builders/amazon/ebs
source "amazon-ebs" "vm" {
  region            = "us-east-2"
  subnet_id         = "subnet-06a7a4a5cd34e2e75"
  security_group_id = "sg-08d59db1e3df8fe8a"
  ami_name          = "packer-linux-dev-box-${formatdate("YYYY-MMM-DD-hh-mm", timestamp())}"

  source_ami                  = "ami-0ff39345bd62c82a5" # Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2022-12-06
  instance_type               = "t3.small"
  associate_public_ip_address = true

  launch_block_device_mappings {
    device_name = "/dev/sda1"
    volume_size = 20
    delete_on_termination = true
  }

  tags = {
    "Name" = "packer-linux-dev-box"
    "date" = formatdate("YYYY-MM-DD hh:mm", timestamp())
  }
  run_tags = {
    "Name" = "packer-temporary-build-server"
  }
}