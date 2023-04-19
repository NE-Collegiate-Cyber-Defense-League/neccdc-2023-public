build {
  name = "linux-builder"
  source "source.amazon-ebs.vm" {
    ssh_username = "admin"
  }
  provisioner "ansible" {
    # https://www.packer.io/plugins/provisioners/ansible/ansible
    # galaxy_file   = "/Users/XXX/code/NAME/collections/requirements.yml"
    playbook_file = "../playbook.yaml"
    use_proxy     = false
  }
}
