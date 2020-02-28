resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/ecs/${var.name}-log-group"
  retention_in_days = 30

  tags = {
    Name = "${var.name}-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "cb_log_stream" {
  name           = "${var.name}-log-stream"
  log_group_name = aws_cloudwatch_log_group.log_group.name
}
