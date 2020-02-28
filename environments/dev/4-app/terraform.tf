provider "aws" {
  region = var.region
  version = "~> 2.51"
}

terraform {
  backend "s3" {
    bucket = "dev-sinewave-new-state-file"
    key    = "4-app/terraform.tfstate"
    region = "us-east-2"
  }
}
