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

variable "ecs_cluster_name" {
  description = "Required by the AWS ECS AMI"
  default     = "SpliceDemo"
}

data "aws_availability_zones" "available" {}
