# ================= ecs task execution role ===================
resource "aws_iam_role" "ecs_task_execution" {
  name_prefix        = "ecs_task_execution"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution.json
}

data "aws_iam_policy_document" "ecs_task_execution" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}
resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}


#resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_and_logs" {
#  role       = "${aws_iam_role.ecs_task_execution.name}"
#  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
#}
# ================= ecs task execution role ===================


# ================= instance role and profile =================

data "aws_iam_policy_document" "ecs_container_instance" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_container_instance" {
  name_prefix        = "ecs_container_instance-"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ecs_container_instance.json
}

resource "aws_iam_role_policy_attachment" "ecs_container_instance" {
  role       = aws_iam_role.ecs_container_instance.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ecs_container_instance_s3_readonly" {
  role       = aws_iam_role.ecs_container_instance.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}
# ================= instance role and profile =================
