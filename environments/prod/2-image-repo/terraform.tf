provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {
    bucket = "prod-site-uploader-state-file"
    key    = "2-image-repo/terraform.tfstate"
    region = "us-west-1"
  }
}
