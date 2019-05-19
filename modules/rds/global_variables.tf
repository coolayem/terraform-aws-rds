// Global variables for all modules

variable env_name {}

variable aws_region {
  default = "us-east-1"
}

variable az_overrides {
  type = "list"
  default = []
}

variable "tags" {
  default = {}
}


variable "subnet_id" {
  default = []
}

variable "az" {
  default = []
}

variable "sg_id" {
  default = ""
}

variable "private_zone_id" {
  default = ""
}

variable "dns_domain" {
  default = ""
}

variable "instance_type" {
  default = "t2.micro"
}

variable "os" {
  default = "rhel-7.4"
}

variable "bastion" {
  default = ""
}

variable "vpc_id" {
  default = ""
}

