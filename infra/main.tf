terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_regions" "available" {}

output "aws_regions" {
  value = data.aws_regions.available.names
}
