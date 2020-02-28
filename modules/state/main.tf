resource "aws_kms_key" "tfstate_encryption_key" {
  description             = "This key is used to encrypt terraform state"
  deletion_window_in_days = 10
  tags = {
    Name = "tfstate_encryption_key",
    env  = "${var.env}"
  }
}

resource "aws_s3_bucket" "tfstate_remote_store" {
  bucket = "${var.env}-${var.name}-state-file"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${aws_kms_key.tfstate_encryption_key.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

