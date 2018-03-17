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

variable "ec2_amis" {
  description = "Ubuntu Server 16.04 LTS (HVM)"
  type        = "map"

  default = {
    "us-east-1" = "ami-43a15f3e"
    "us-east-2" = "ami-916f59f4"
    "us-west-1" = "ami-07585467"
    "us-west-2" = "ami-79873901"
  }
}
