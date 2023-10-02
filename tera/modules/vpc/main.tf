# modules/vpc/main.tf
# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest

module "vpc" {
  source = "../../public_modules/terraform-aws-vpc-master"
  # version = "3.0.0"
  # insert the 49 required variables here

  name = "tutcert-vpc"
  cidr = var.vpc_cidr


  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]


  # Single NAT Gateway, see docs linked above
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  tags = {
    Name        = "tutcert-vpc"
    Project     = "tutcert.zerosubstance.org"
    Environment = "development"
    ManagedBy   = "terraform"
  }

  private_subnet_tags = {
    Name = "tutcert-private-subnet"
    Role = "private"
  }

  public_subnet_tags = {
    Name = "tutcert-public-subnet"
    Role = "public"
  }
}

