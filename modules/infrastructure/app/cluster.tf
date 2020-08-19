data "aws_ami" "ecs_optimized" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-2.0.20190709-x86_64-ebs"]
  }
}

data "template_file" "user_data" {
  template = "${file("${path.module}/templates/user_data.yaml")}"

  vars = {
    cluster_name = local.app_full_name
    env          = var.env
    nfs_ip       = local.nfs_ip
  }
}

resource "aws_security_group" "ecs_container_instance" {
  vpc_id = local.vpc_id
  name   = "${local.app_full_name}-ecs_container_instance"

  ingress {
    protocol    = "tcp"
    from_port   = var.app_port
    to_port     = var.app_port
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description     = "allow ssh access from bastion"
    protocol        = "tcp"
    from_port       = 22
    to_port         = 22
    security_groups = [data.aws_security_group.bastion.id]
  }

  ingress {
    description = "allow ssh access from vpc"
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_autoscaling_group" "app" {
  name_prefix          = "${local.app_full_name}-"
  vpc_zone_identifier  = local.app_subnet_ids
  launch_configuration = aws_launch_configuration.app.name

  desired_capacity = var.instance_size
  min_size         = 2
  max_size         = 4
}

resource "aws_launch_configuration" "app" {
  name_prefix          = "${local.app_full_name}-"
  image_id             = data.aws_ami.ecs_optimized.id
  iam_instance_profile = aws_iam_instance_profile.ecs_container_instance.id
  user_data            = data.template_file.user_data.rendered
  instance_type        = var.instance_type
  security_groups = [
    aws_security_group.ecs_container_instance.id,
    data.aws_security_group.database_access.id,
    data.aws_security_group.app.id,
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_instance_profile" "ecs_container_instance" {
  name_prefix = "ecs-instance-profile"
  path        = "/"
  role        = aws_iam_role.ecs_container_instance.id
  provisioner "local-exec" {
    command = "sleep 10"
  }
}
