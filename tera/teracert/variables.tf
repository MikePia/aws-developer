# teracert/variables.tf
variable "region" {
  description = "The AWS region where resources will be created."
}

variable "instance_type" {}
variable "key_name" {}
# variable ami_id {}


# variable "infra_env" {
#   type        = string
#   description = "infrastructure environment"
#   default     = "production"
# }

# variable "default_region" {
#   type = string
#   description = "the region this infrastructure is in"
#   default = "us-east-2"
# }

locals {
  cidr_subnets = cidrsubnets("10.0.0.0/17", 4, 4, 4, 4, 4, 4)
}

variable "vpc_cidr" {}

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

variable "pg_username" {
  type      = string
  sensitive = true
}

variable "pg_password" {
  type      = string
  sensitive = true
}


variable "domain_name" {}
variable "alternative_name" {}
