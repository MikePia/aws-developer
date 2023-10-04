# After adding ec2, supply sgs and setup to sue private subnets (See the Webcommerce setup)

# resource "aws_db_instance" "default" {
#   allocated_storage    = 10
#   db_name              = "mydb"
#   engine               = "mysql"
#   engine_version       = "5.7"
#   instance_class       = "db.t3.micro"
#   username             = "foo"
#   password             = "foobarbaz"
#   multi_az = true
#   backup_retention_period = 14
#   parameter_group_name = "default.mysql5.7"
#   skip_final_snapshot  = true
# }


variable "vpc_id" {}

resource "aws_security_group" "rds_sg" {
  name   = "tutcert_rds_sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "education_rds"
  }

}


# create the subnet group for the rds instance
resource "aws_db_subnet_group" "database_subnet_group" {
  name        = "tutcert_db_subnet_group"
  subnet_ids  = [var.data_subnet1_id, var.data_subnet2_id]
  description = "Private subnet for webserver-db com"

  tags = {
    Name = "zs db subnet group"
  }
}

resource "aws_db_instance" "db_instance" {
  identifier             = "db-instance"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "14.3"
  username               = var.pg_username
  password               = var.pg_password
  db_subnet_group_name   = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  # parameter_group_name   = aws_db_parameter_group.education.name
  publicly_accessible = true
  skip_final_snapshot = true
}