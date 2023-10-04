# modules/ec2/main.tf


resource "aws_security_group" "ssh_access" {
  name   = "allow-all-sg"
  vpc_id = var.vpc_id

  ingress {
    cidr_blocks = [var.my_cidr_1, var.my_cidr_2]

    from_port = 0
    to_port   = 0
    protocol  = "-1"
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
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.public_subnet1_id
  vpc_security_group_ids = ["${aws_security_group.ssh_access.id}"]

  tags = {
    Name = "tutcert_ec2_instance"
  }
}
