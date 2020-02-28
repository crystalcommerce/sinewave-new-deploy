provider "aws" {
  region = var.region
  version = "~> 2.51"
}

terraform {
  backend "s3" {
    bucket = "dev-sinewave-new-state-file"
    key    = "2-image-repo/terraform.tfstate"
    region = "us-east-2"
  }
}
