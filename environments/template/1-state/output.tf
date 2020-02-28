output "state_file_bucket" {
  value = "s3://${module.state.bucket_name}"
}
