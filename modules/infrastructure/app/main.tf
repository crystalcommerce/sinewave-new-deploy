resource "aws_ecs_cluster" "app" {
  name = local.app_full_name
  tags = {
    Name        = var.name
    Environment = var.env
  }
}


data "template_file" "app" {
  template = "${file("${path.module}/templates/app_task_definition.json.tpl")}"

  vars = {
    region       = var.region
    image        = var.image
    port         = var.app_port
    database_url = var.database_url
    master_key   = var.master_key
    server_url   = var.server_url
    redis_url      = var.redis_url
    smtp_password  = var.smtp_password
    log_group    = aws_cloudwatch_log_group.log_group.name
  }
}

resource "aws_ecs_task_definition" "app" {
  family                = local.app_full_name
  container_definitions = data.template_file.app.rendered
  requires_compatibilities = ["EC2"]
  memory                   = "4096"
  network_mode             = "host"
}

resource "aws_ecs_service" "app" {
  name            = local.app_full_name
  cluster         = aws_ecs_cluster.app.id
  launch_type     = "EC2"
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.desired_count
  iam_role        = aws_iam_role.ecs_task_execution.arn
  deployment_minimum_healthy_percent = 0

  load_balancer {
    target_group_arn = aws_alb_target_group.app.arn
    container_name   = "app"
    container_port   = var.app_port
  }

  depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs_container_instance]
}
