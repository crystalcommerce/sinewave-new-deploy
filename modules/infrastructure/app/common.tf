locals {
  vpc_id         = data.aws_vpc.vpc.id
  app_subnet_ids = data.aws_subnet_ids.app.ids
  dmz_subnet_ids = data.aws_subnet_ids.dmz.ids

  app_full_name = "${var.env}-${var.name}" # app full name

  nfs_ip = "99.99.99.99" #TODO: need to find out why 99.99.99.99 is resolved to nfs ip in dev and prod environment
}

data "aws_vpc" "vpc" {
  tags = {
    "Name" = "network-vpc-${var.env}"
  }
}

data "aws_subnet_ids" "app" {
  vpc_id = local.vpc_id
  filter {
    name   = "tag:Name"
    values = ["App Subnet*"]
  }
}

data "aws_subnet_ids" "dmz" {
  vpc_id = local.vpc_id
  filter {
    name   = "tag:Name"
    values = ["DMZ Subnet*"]
  }
}

data "aws_security_group" "database_access" {
  vpc_id = local.vpc_id
  filter {
    name   = "tag:Name"
    values = ["${local.app_full_name}-db-access-sg"]
  }
}

data "aws_security_group" "bastion" {
  vpc_id = local.vpc_id
  filter {
    name   = "tag:Name"
    values = ["sg-bastion-${var.env}"]
  }
}

data "aws_security_group" "app" {
  vpc_id = local.vpc_id
  filter {
    name   = "tag:Name"
    values = ["sg-Apps-${var.env}"]
  }
}

data "aws_acm_certificate" "elb_certificate" {
  domain      = "*.${var.domain}"
  most_recent = true
  statuses    = ["ISSUED"]
}
