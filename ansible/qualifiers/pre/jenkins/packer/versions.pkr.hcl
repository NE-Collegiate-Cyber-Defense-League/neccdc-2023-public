packer {
  required_plugins {
    amazon = {
      version = "1.1.0"
      source  = "github.com/hashicorp/amazon"
      # https://github.com/hashicorp/packer-plugin-amazon
    }
  }
}