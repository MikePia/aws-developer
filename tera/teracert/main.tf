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
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
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
  vpc_id        = module.vpc.vpc_id
  # public_subnets = module.vpc.public_subnets
  # iam_instance_profile = module.iam.iam_instance_profile_name
  public_subnet1_id = module.vpc.public_subnet1_id
  my_cidr_1         = var.my_cidr_1
  my_cidr_2         = var.my_cidr_2
}

#  Create role based access from our ec2 to the database and to buckets
module "iam" {
  source = "../modules/iam"

}


module "vpc" {

  source            = "../modules/vpc"
  data_subnet1_id   = module.vpc.data_subnet1_id
  data_subnet2_id   = module.vpc.data_subnet2_id
  public_subnet1_id = module.vpc.public_subnet1_id
  # public_subnets = module.vpc.public_subnets.id
  my_cidr_1 = var.my_cidr_1
  my_cidr_2 = var.my_cidr_2
}

module "rdc" {
  source          = "../modules/rds"
  vpc_id          = module.vpc.vpc_id
  data_subnet1_id = module.vpc.data_subnet1_id
  data_subnet2_id = module.vpc.data_subnet2_id
  # public_subnet1_id = module.vpc.public_subnet1_id
  pg_username = var.pg_username
  pg_password = var.pg_password

}

module "dbd" {

  source = "../modules/dbd"

  
}




module "acm" {
  source = "../modules/acm"
  domain_name = var.domain_name
  alternative_name = var.alternative_name
}

module "alb" {
  source = "../modules/alb"
  public_subnet1_id = module.vpc.public_subnet1_id
  public_subnet2_id = module.vpc.public_subnet2_id
  vpc_id = module.vpc.vpc_id
  certificate_arn = module.acm.certificate_arn
  
}