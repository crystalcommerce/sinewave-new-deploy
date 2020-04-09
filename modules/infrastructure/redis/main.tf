locals {
  full_name = "${var.env}-${var.name}"
}
resource "aws_elasticache_cluster" "redis" {
  cluster_id         = var.name
  engine             = "redis"
  node_type          = var.node_type
  num_cache_nodes    = 1
  engine_version     = var.engine_version
  port               = 6379
  subnet_group_name  = aws_elasticache_subnet_group.redis.name
  security_group_ids = var.security_group_ids

  tags = {
    Environemnt = var.env
    Name        = local.full_name
  }
}


resource "aws_elasticache_subnet_group" "redis" {
  name       = "${local.full_name}-sg"
  subnet_ids = var.subnet_ids
}
