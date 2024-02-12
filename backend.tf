terraform {
  backend "s3" {
    bucket = "089432-terraform-state-static-website-ioc"
    key    = "terraform-state/terraform.tfstate"
    region = "us-east-1"
  }
}
