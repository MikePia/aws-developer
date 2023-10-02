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
