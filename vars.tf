# # # vars.tf # # #

variable "aws_access_key" {
  description = "AWS access key, must pass on command line using -var"
}

variable "aws_secret_key" {
  description = "AWS secret access key, must pass on command line using -var"
}

variable "aws_region" {
  description = "US West Oregon"
  default     = "us-west-2"
}

variable "ec2_ami" {
  description = "Ubuntu Server 16.04 LTS (HVM)"
  default     = "ami-79873901"
}

variable "ec2_instance_type" {
  description = "Use small and cheap EC2 instances"
  default     = "t2.micro"
}

# dynamically retrieves all availability zones for current region
data "aws_availability_zones" "available" {}
