module "database" {
  source            = "../../../modules/infrastructure/db"
  database_name     = var.database_name
  database_username = var.database_username
  database_password = var.database_password
  region            = var.region
  env               = var.env
}
