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

variable "ec2_availability_zones" {
  description = "Map of all availability zones in us-west-2"

  default = {
    "0" = "us-west-2a"
    "1" = "us-west-2b"
    "2" = "us-west-2c"
  }
}

variable "ec2_instance_count" {
  description = "The number of EC2 instances to run behind the load balancer"
  default     = 2
}
