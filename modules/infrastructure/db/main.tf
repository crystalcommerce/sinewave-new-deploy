terraform {
  required_version = "= 0.12.6"
  # Intentionally empty. Will be filled by Terragrunt.
  backend "s3" {}
}

provider "aws" {
  region = "${var.region}"
}

data "aws_vpc" "vpc" {
  tags = {
    "Name" = "network-vpc-${var.env}"
  }
}

data "aws_subnet_ids" "db" {
  vpc_id = "${local.vpc_id}"
  filter {
    name   = "tag:Name"
    values = ["DB Subnet*"]
  }
}

locals {
  vpc_id        = "${data.aws_vpc.vpc.id}"
  db_subnet_ids = "${data.aws_subnet_ids.db.ids}"
  db_id         = "${var.env}-${replace(var.database_name, "_", "-")}"
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${local.db_id}-db-subnet-group"
  subnet_ids = "${data.aws_subnet_ids.db.ids}"

  tags = {
    Environment = "${var.env}"
  }
}

/* Security Group for resources that want to access the Database */
resource "aws_security_group" "db_access_sg" {
  vpc_id      = "${local.vpc_id}"
  name        = "${local.db_id}-db-access-sg"
  description = "Allow access to RDS"

  tags = {
    Name        = "${local.db_id}-db-access-sg"
    Environment = "${var.env}"
  }
}

resource "aws_security_group" "database-sg" {
  vpc_id = "${local.vpc_id}"

  //allow traffic for TCP 5432
  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = ["${aws_security_group.db_access_sg.id}"]
  }

  // outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = "${var.env}"
  }
}

resource "aws_db_instance" "database" {
  identifier              = "${local.db_id}"
  engine                  = "postgres"
  engine_version          = "${var.engine_version}"
  instance_class          = "${var.instance_type}"
  allocated_storage       = "${var.allocated_storage}"
  name                    = "${var.database_name}"
  password                = "${var.database_password}"
  username                = "${var.database_username}"
  vpc_security_group_ids  = "${aws_security_group.database-sg.*.id}"
  db_subnet_group_name    = "${aws_db_subnet_group.rds_subnet_group.name}"
  skip_final_snapshot     = true
  backup_window           = "00:00-00:30"
  backup_retention_period = "7"

  tags = {
    Environment = "${var.env}"
  }
}
