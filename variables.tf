variable "region" {
  type = string
}
variable "key_name" {
  type = string
}
variable "s3_bucket" {
  type = string
}
variable "min_size" {
  type = number
}
variable "max_size" {
  type = number
}


variable "asg_policy_name" {
  type = string
}
variable "asg_name" {
  type = string
}
variable "elb_name" {
  type = string
}

variable "launch_config_name" {
  type = string
}
variable "healthy_threshold" {
  type    = number
  default = 2
}
variable "unhealthy_threshold" {
  type    = number
  default = 2
}
variable "launch_config_sg_name" {
  type = string
}
variable "elb_sg_name" {
  type = string
}


variable "server_port" {
  description = "The port the server will use for HTTP requests"
  default     = 80
}

variable "ssh_port" {
  type    = number
  default = 22
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "target_value" {
  type = string
}