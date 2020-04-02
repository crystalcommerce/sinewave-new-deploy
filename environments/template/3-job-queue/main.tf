
data "aws_security_group" "sg_cache" {
  vpc_id = "${var.vpc_id}"
  filter {
    name   = "tag:Name"
    values = ["sg-cache-${var.env}"]
  }
}


module "job-queue" {
  source             = "../../../modules/infrastructure/redis"
  name               = "${var.name}-queue"
  env                = var.env
  subnet_ids         = var.app_subnet_ids
  security_group_ids = [data.aws_security_group.sg_cache.id]
  node_type          = var.queue_node_type
}
