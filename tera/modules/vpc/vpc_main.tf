
# modules/vpc/main_vpc.tf
resource "aws_vpc" "tutcert_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true


  tags = {
    Name = "tutcert-vpc"
  }
}

resource "aws_internet_gateway" "tutcert_internet_gateway" {
  vpc_id = aws_vpc.tutcert_vpc.id
  tags = {
    Name = "tutcert-igw"
  }
}

# use data source to get all avalablility zones in region
data "aws_availability_zones" "available_zones" {}

# #######################################################
#  Create public subnets with route table and entries
# #######################################################


resource "aws_subnet" "tutcert_public_subnet_1" {
  vpc_id                  = aws_vpc.tutcert_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available_zones.names[0]

  tags = {
    Name = "tutcert-public-subnet-1"
  }
}

resource "aws_subnet" "tutcert_public_subnet_2" {
  vpc_id                  = aws_vpc.tutcert_vpc.id
  cidr_block              = "10.123.101.0/24"
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available_zones.names[1]

  tags = {
    Name = "tutcert-public-subnet-2"
  }
}


resource "aws_route_table" "tutcert_public_rt" {
  vpc_id = aws_vpc.tutcert_vpc.id


  tags = {
    Name = "tutcert-public-rt"
  }
}

# Create default route for all outbound traffic through igw
resource "aws_route" "default_route" {

  route_table_id = aws_route_table.tutcert_public_rt.id

  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.tutcert_internet_gateway.id

}

# associate public subnet1 wity public route table
resource "aws_route_table_association" "tutcert_rt_assoc_pub_subnet1" {
  subnet_id      = aws_subnet.tutcert_public_subnet_1.id
  route_table_id = aws_route_table.tutcert_public_rt.id

}

# associate public subnet2 wity public route table
resource "aws_route_table_association" "tutcert_rt_assoc_pub_subnet2" {
  subnet_id      = aws_subnet.tutcert_public_subnet_2.id
  route_table_id = aws_route_table.tutcert_public_rt.id

}

# #######################################################
#  Create Private subnets for database access
# #######################################################

resource "aws_subnet" "tutcert_private_data_subnet1" {
  vpc_id            = aws_vpc.tutcert_vpc.id
  cidr_block        = "10.123.2.0/24"
  availability_zone = data.aws_availability_zones.available_zones.names[0]

}

resource "aws_subnet" "tutcert_private_data_subnet2" {
  vpc_id            = aws_vpc.tutcert_vpc.id
  cidr_block        = "10.123.102.0/24"
  availability_zone = data.aws_availability_zones.available_zones.names[1]

}


# #######################################################
#  Create all area developers access from my personal machine using aws sg
# #######################################################

resource "aws_security_group" "tutcert_dev_sg" {
  name        = "tutcert_dev_sg"
  description = "tutcert security group"
  vpc_id      = aws_vpc.tutcert_vpc.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.my_cidr_1, var.my_cidr_2]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

