variable "env" {

}

variable "region" {

}

variable "name" {

}

variable "image" {

}

variable "desired_count" {
  description = "number of desired running task"
}

variable "app_port" {
  default = 80
}


variable "database_url" {

}

variable "master_key" {
  description = "rails master key"
}


variable "health_check_path" {
  default = "/health-check"
}

variable "instance_type" {

}
variable "instance_size" {

}

variable "domain" {
  description = "used to look up acn certificates"

}

