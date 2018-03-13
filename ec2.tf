# # # ec2.tf # # #

# SSH keypair for debugging

resource "aws_key_pair" "splice_demo" {
  key_name   = "splice-demo-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDTpWlB2GQxjuaZzdr5RvhyMLE0fIdXf61U3YnotT3L3RK16D9LnLsFpnM9NUmBIQ0uCg+dErp54l5htwm8Wb1qURRbWXYq9Yc9hlUDqIvW3/z3vdGkwb2BSUYvx/5mtGFQZZWorgtuT0r3vBW0KJG3Qu1TCJwyQ20ksCHFYy4jlT/kH+HjodeSK810WNm07+pc5mfnEsgMkL+XZOydZYUy9V27Q2b492IFG+uwfIVH+yJTvs2rlV/7gzT9mTK76kDTzub0X3jNDXZMP1lOIcIP9AszDQ6+RdKZ7GXv2a243LoeQQ6YJJbhAUvQDzktZDvEhcjUzNWYNvAhS9HfrfXD"
}

# Security Group for ec2 instances

resource "aws_security_group" "splice_demo_ec2" {
  name = "Splice-Demo-EC2-SG"

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}

# EC2 instances

resource "aws_instance" "splice_demo" {
  ami                         = "${var.ec2_ami}"
  associate_public_ip_address = false
  availability_zone           = "${lookup(var.ec2_availability_zones, count.index)}"
  count                       = "${var.ec2_instance_count}"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.splice_demo.key_name}"
  user_data                   = "${file("user_data.sh")}"

  vpc_security_group_ids = [
    "${aws_security_group.splice_demo_ec2.id}",
  ]

  tags {
    Name = "Splice Demo ${count.index}"
  }
}
