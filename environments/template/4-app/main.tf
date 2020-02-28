module "app" {
  source            = "../../../modules/infrastructure/app"
  region            = var.region
  env               = var.env
  image             = var.image
  name              = var.name
  desired_count     = "1"
  database_url      = var.database_url
  master_key        = var.master_key
  health_check_path = var.health_check_path
  domain            = var.domain
  app_id            = var.app_id
  secret            = var.secret
  instance_type     = var.instance_type
  instance_size     = var.instance_size
}
