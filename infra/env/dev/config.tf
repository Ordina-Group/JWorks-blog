terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.39.0"
    }
  }

  backend "s3" {
    bucket = "jworks-tech-blog-dev-terraform-state"
    key    = "blog.tfstate"
    region = "eu-west-1"
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      "app" = "jworks-tech-blog"
    }
  }
}