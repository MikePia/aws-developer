# modules/ec2/main.tf

resource "aws_instance" "tutcert_ec2_instance" {
  # ami           = data.aws_ami.ubuntu.id
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  # iam_instance_profile = var.iam_instance_profile

  tags = {
    Name = "tutcert_ec2_instance"
  }
}
