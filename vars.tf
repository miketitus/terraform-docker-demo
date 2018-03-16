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

# dynamically retrieves all availability zones for current region
data "aws_availability_zones" "available" {}

variable "ec2_ami" {
  description = "Ubuntu Server 16.04 LTS (HVM)"
  default     = "ami-79873901"
}

variable "ec2_instance_type" {
  description = "Use small and cheap EC2 instances"
  default     = "t2.micro"
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}

variable "az_a_subnet_cidr" {
    description = "CIDR for AZ A"
    default = "10.0.0.0/24"
}
