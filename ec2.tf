# # # ec2.tf # # #

resource "aws_key_pair" "splice_demo" {
  key_name   = "splice-demo-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDTpWlB2GQxjuaZzdr5RvhyMLE0fIdXf61U3YnotT3L3RK16D9LnLsFpnM9NUmBIQ0uCg+dErp54l5htwm8Wb1qURRbWXYq9Yc9hlUDqIvW3/z3vdGkwb2BSUYvx/5mtGFQZZWorgtuT0r3vBW0KJG3Qu1TCJwyQ20ksCHFYy4jlT/kH+HjodeSK810WNm07+pc5mfnEsgMkL+XZOydZYUy9V27Q2b492IFG+uwfIVH+yJTvs2rlV/7gzT9mTK76kDTzub0X3jNDXZMP1lOIcIP9AszDQ6+RdKZ7GXv2a243LoeQQ6YJJbhAUvQDzktZDvEhcjUzNWYNvAhS9HfrfXD"
}

# TODO security group
# TODO mod count.index?

resource "aws_instance" "splice_demo" {
  ami                         = "${var.ec2_ami}"
  associate_public_ip_address = "true"
  availability_zone           = "${lookup(var.ec2_availability_zones, count.index)}"
  count                       = 1
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.splice_demo.key_name}"
  user_data                   = "${file("user_data.txt")}"

  tags {
    Name = "Splice Demo ${count.index}"
  }
}
