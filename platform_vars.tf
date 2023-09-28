variable "image_version_console" {
  description = "Console version to Deploy"
  default     = "v7.02.000"
}

variable "image_version_agent" {
  description = "Agent version to Deploy"
  default     = "v7.02.000"
}

variable "aws_region" {
  description = "The AWS Region"
}

variable "aws_account" {
  description = "The AWS account number where resources are being deployed"
}

variable "vpc" {
  description = "The VPC in which to place the public facing Console"
}

variable "cidr" {
  description = "cidr block"
}

variable "subnet_a_id" {
  description = "Subnet A ID"
}

variable "subnet_b_id" {
  description = "Subnet B ID"
}

variable "email" {
  description = "email address for Console management website account"
}

variable "ssm_doc_name_prefix" {
  description = "The prefix you created during the pre-requisite process"
}