output "endpoint" {
  value = "https://${aws_route53_record.lb_name.name}"
}
