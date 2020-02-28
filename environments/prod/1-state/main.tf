provider "aws" {
  region = "${var.region}"
}

module "state" {
  source = "../../../modules/state"
  env    = var.env
  name   = var.name
}
