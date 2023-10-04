# modules/ec2/variables.tf

variable "instance_type" {
  description = "The type of EC2 instance to launch."
}

variable "key_name" {
  description = "The name of the EC2 key pair to use."
}


variable "ami_id" {
  description = "The AMI ID for the EC2 instance."
}

variable "vpc_id" {}

variable "public_subnet1_id" {}
# variable public_subnets {}

variable "my_cidr_1" {
  type      = string
  sensitive = true
  default   = "noyb"
}
variable "my_cidr_2" {
  type      = string
  sensitive = true
  default   = "noyb"
}