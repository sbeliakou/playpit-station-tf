terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }

  # backend "s3" {
  #   bucket = "mybucket"
  #   key    = "path/to/my/key"
  # }
}

provider "aws" {
  region = var.aws_region
}
