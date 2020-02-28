output "bucket_name" {
  value = aws_s3_bucket.tfstate_remote_store.id
}
