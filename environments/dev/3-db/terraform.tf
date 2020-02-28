provider "aws" {
  region = var.region
  version = "~> 2.51"
}

terraform {
  backend "s3" {
    bucket = "dev-sinewave-new-state-file"
    key    = "3-db/terraform.tfstate"
    region = "us-east-2"
  }
}
