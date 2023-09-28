# teracert/main.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


provider "aws" {
  region  = var.region
  profile = "default"
}

# The data resource to retrive an ami
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


# Create an ami
module "ec2" {
  source = "../modules/ec2"

  ami_id        = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name # Replace with your key pair name
  # iam_instance_profile = module.iam.iam_instance_profile_name
}

#  Create role based access from our ec2 to the database and to buckets
module "iam" {
  source = "../modules/iam"

}


module "vpc" {

  source = "../modules/vpc"

#   vpc_cidr        = var.vpc_cidr
#   public_subnets  = module.vpc.public_subnets
#   private_subnets = module.vpc.private_subnets
}