provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {
    bucket = "prod-site-uploader-state-file"
    key    = "3-db/terraform.tfstate"
    region = "us-west-1"
  }
}
