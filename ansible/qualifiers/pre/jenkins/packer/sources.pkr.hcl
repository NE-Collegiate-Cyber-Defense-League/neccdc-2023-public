# https://www.packer.io/plugins/builders/amazon/ebs
source "amazon-ebs" "vm" {
  region            = "us-east-2"
  subnet_id         = "subnet-06a7a4a5cd34e2e75"
  security_group_id = "sg-08d59db1e3df8fe8a"
  ami_name          = "packer-jenkins-${formatdate("YYYY-MMM-DD-hh-mm", timestamp())}"

  source_ami                  = "ami-06a7641d5bd7bdc65" # Debian 11
  instance_type               = "t3.small"
  associate_public_ip_address = true

  launch_block_device_mappings {
    device_name = "/dev/sda1"
    volume_size = 20
    delete_on_termination = true
  }

  tags = {
    "Name" = "packer-jenkins"
    "date" = formatdate("YYYY-MM-DD hh:mm", timestamp())
  }
  run_tags = {
    "Name" = "packer-temporary-build-server"
  }
}
