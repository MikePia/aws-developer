# modules/ec2/outputs.tf
output "instance_public_ip" {
  value = aws_instance.tutcert_ec2_instance.public_ip
}

# teracert/modules/ec2/outputs.tf
output "ami_id" {
  value = aws_instance.tutcert_ec2_instance.ami
}

