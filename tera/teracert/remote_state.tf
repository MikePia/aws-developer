# store the terraform state file in s3
terraform {
  backend "s3" {
    bucket  = "dj-start-remote-state"
    key     = "tutcert/terraform.tfstate"
    region  = "us-east-1"
    profile = "default"
  }
}
