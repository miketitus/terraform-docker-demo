# # # main.tf # # #

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

output "url" {
  value = "http://${aws_elb.splice_demo.dns_name}/"
}
