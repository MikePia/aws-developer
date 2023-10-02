# modules/ec2/main.tf

 
resource "aws_security_group" "ssh_access" {
  name   = "allow-all-sg"
  vpc_id = var.vpc_id

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }

  // Terraform removes the default rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "tutcert_ec2_instance" {
  # ami           = data.aws_ami.ubuntu.id
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id = var.public_subnets

  # iam_instance_profile = var.iam_instance_profile

  security_groups = ["${aws_security_group.ssh_access.id}"]

  tags = {
    Name = "tutcert_ec2_instance"
  }
}
