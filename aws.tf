variable "aws_region" {
  description = "The AWS Region"
}

variable "aws_account" {
  description = "The AWS account number where resources are being deployed"
}

provider "aws" {
  region  = var.aws_region
  version = "~> 4.0"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }

  }
}
