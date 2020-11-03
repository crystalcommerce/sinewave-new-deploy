resource "aws_security_group" "lb" {
  name        = "${local.app_full_name}-lb-sg"
  description = "controls access to the ALB"
  vpc_id      = local.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = "443"
    to_port     = "443"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_alb" "app_lb" {
  name            = "${local.app_full_name}-lb"
  subnets         = local.dmz_subnet_ids
  security_groups = [aws_security_group.lb.id]
}

resource "aws_alb_target_group" "app" {
  name        = "${local.app_full_name}-target-group"
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = local.vpc_id
  target_type = "instance"

  health_check {
    healthy_threshold   = "3"
    interval            = "240"
    protocol            = "HTTP"
    matcher             = "200,201,300"
    timeout             = "120"
    path                = var.health_check_path
    unhealthy_threshold = "10"
  }
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.app_lb.id
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = data.aws_acm_certificate.elb_certificate.arn

  default_action {
    target_group_arn = aws_alb_target_group.app.arn
    type             = "forward"
  }
}

data "aws_route53_zone" "primary" {
  name = var.domain
}

locals {
  app_domain_name = "${var.name}.${var.env == "prod" ? "" : "${var.env}."}${var.domain}"
}


resource "aws_route53_record" "lb_name" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = local.app_domain_name
  type    = "A"

  alias {
    name                   = aws_alb.app_lb.dns_name
    zone_id                = aws_alb.app_lb.zone_id
    evaluate_target_health = true
  }
}
