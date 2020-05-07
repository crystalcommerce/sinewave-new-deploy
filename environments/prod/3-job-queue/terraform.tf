provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "dev-sinewave-new-state-file"
    key    = "3-job-queue/terraform.tfstate"
    region = "us-east-2"
  }
}
