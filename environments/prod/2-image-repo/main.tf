module "image_repo" {
  source = "../../../modules/infrastructure/image-repo"
  name   = var.name
  env    = var.env
  region = var.region
}
