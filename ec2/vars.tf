# # # vars.tf # # #

variable "aws_access_key" {
  description = "AWS access key, must pass on command line"
}

variable "aws_secret_key" {
  description = "AWS secret access key, must pass on command line"
}

variable "aws_region" {
  description = "US West Oregon"
  default     = "us-west-2"
}

variable "ec2_ami" {
  description = "Ubuntu Server 16.04 LTS (HVM)"
  default     = "ami-79873901"
}

data "aws_availability_zones" "available" {}
