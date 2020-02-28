locals {
  full_name = "${var.env}-${var.name}"
}
resource "aws_ecr_repository" "image_repo" {
  name = local.full_name

  tags = {
    Name        = local.full_name
    Environment = var.env
  }
}
