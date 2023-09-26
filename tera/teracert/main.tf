# teracert/main.tf
provider "aws" {
  region = var.region
}

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


module "ec2" {
  source = "../modules/ec2"

  # ami_id               = module.ec2.ami_id
  ami_id               = data.aws_ami.ubuntu.id
  instance_type        = var.instance_type
  key_name             = var.key_name    # Replace with your key pair name
  # iam_instance_profile = module.iam.iam_instance_profile_name
}

module "iam" {
  source = "../modules/iam"

}
