provider "aws" {
  region  = var.region
  version = "~> 2.51"
}

module "state" {
  source = "../../../modules/state"
  env    = var.env
  name   = var.name
}
