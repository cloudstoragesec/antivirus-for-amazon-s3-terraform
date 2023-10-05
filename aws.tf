variable "aws_region" {
  description = "The AWS Region"
}

variable "aws_account" {
  description = "The AWS account number where resources are being deployed"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    awscc = {
      source  = "hashicorp/awscc"
      version = "~> 0.1"
    }
  }
}

provider "awscc" {
  region = var.aws_region
}

provider "aws" {
  region = var.aws_region
}



