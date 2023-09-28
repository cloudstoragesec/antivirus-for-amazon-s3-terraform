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
