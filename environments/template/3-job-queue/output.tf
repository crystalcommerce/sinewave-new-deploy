output "job_queue_address" {
  value = "redis://${module.job-queue.address}:6379"
}
