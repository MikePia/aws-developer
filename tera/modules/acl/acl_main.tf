# modules/acl/main.tf
resource "aws_network_acl" "main" {
  vpc_id = var.vpc_id

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = var.vpc_cidr
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.vpc_cidr
    from_port  = 80
    to_port    = 80
  }

  tags = {
    Name = "main"
  }
}