variable "vpc_cidr" {
  type        = string
  description = "The IP range to use for the VPC"
  default     = "10.0.0.0/16"
}

variable "data_subnet1_id" {}


variable "data_subnet2_id" {}

variable "public_subnet1_id" {}

variable "my_cidr_1" {
  type      = string
  sensitive = true
  default   = "noyb"

}
variable "my_cidr_2" {
  type      = string
  sensitive = true
  default   = "noyb"
}

# variable "public_subnets" {
#   type = list(string)
#   description = "subnets to create for public network traffic, one per AZ"
# }

# variable "private_subnets" {
#   type = list(string)
#   description = "subnets to create for private network traffic, one per AZ"
# }