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

variable "Email" {
  description = "Email address for Console management website account"
}

variable "ssm_schema_doc_name" {
  description = "Name of the SSM Schema Document you created during the pre-requisite process"
}

variable "ssm_doc_name" {
  description = "Name of the SSM Document you created during the pre-requisite process"
}
