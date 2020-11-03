module "app" {
  source            = "../../../modules/infrastructure/app"
  region            = var.region
  env               = var.env
  image             = var.image
  name              = var.name
  desired_count     = "1"
  database_url      = var.database_url
  redis_url         = var.redis_url
  smtp_password     = var.smtp_password
  master_key        = var.master_key
  health_check_path = var.health_check_path
  domain            = var.domain
  instance_type     = var.instance_type
  instance_size     = var.instance_size
  server_url        = var.server_url
  dsn_key           = var.dsn_key
}