provider "aws" {
  region = var.region
}

terraform {
  required_version = "~> 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }

  backend "s3" {
    bucket = "terraform-states-1234567890"
    key    = "blog/manual/prod/terraform.tfstate"
    region = "us-east-1"
  }
}
