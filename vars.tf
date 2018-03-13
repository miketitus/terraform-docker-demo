# # # vars.tf # # #

variable "aws_access_key" {
  description = "AWS access key, must pass on command line"
}

variable "aws_secret_key" {
  description = "AWS secret access key, must pass on command line"
}

variable "aws_region" {
  default = "us-west-2"
}

variable "ec2_ami" {
  description = "Ubuntu Server 16.04 LTS (HVM)"
  default     = "ami-79873901"
}

variable "ec2_availability_zones" {
  default = {
    "0" = "us-west-2a"
    "1" = "us-west-2b"
    "2" = "us-west-2c"
  }
}
