# modules/ec2/variables.tf

variable "instance_type" {
  description = "The type of EC2 instance to launch."
}

variable "key_name" {
  description = "The name of the EC2 key pair to use."
}


variable "ami_id" {
  description = "The AMI ID for the EC2 instance."
}
