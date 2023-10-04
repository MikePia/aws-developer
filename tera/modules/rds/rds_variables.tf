variable "data_subnet1_id" {}
variable "data_subnet2_id" {}

variable "pg_username" {
  type      = string
  sensitive = true
}

variable "pg_password" {
  type      = string
  sensitive = true

}
