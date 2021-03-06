provider "aws" {
  region = var.region
  version = "~> 2.51"
}

terraform {
  backend "s3" {
    bucket = "prod-sinewave-new-state-file"
    key    = "3-db/terraform.tfstate"
    region = "us-west-1"
  }
}
