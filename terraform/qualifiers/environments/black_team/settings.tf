terraform {
  required_version = "1.3.7"

  backend "s3" {
    bucket = "neccdl-terraform-example-bucket"
    key    = "qualifiers/black_team/terraform.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.30.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}
