provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {
    bucket = "dev-site-uploader-state-file"
    key    = "3-db/terraform.tfstate"
    region = "us-east-2"
  }
}
