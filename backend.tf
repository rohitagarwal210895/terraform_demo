terraform {
  backend "s3" {
    bucket = "terraform-demo-test"
    key    = "path/terraform.tfstate"
    region = "us-west-1"
  }
}
