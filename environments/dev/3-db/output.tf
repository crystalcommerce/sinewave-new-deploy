output "database_url" {
  value = "postgres://${var.database_username}:${var.database_password}@${module.database.endpoint}/${var.database_name}"
}

