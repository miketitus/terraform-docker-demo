# # # ec2.tf # # #

# Security Group for EC2 instances

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
  availability_zone           = "${element(data.aws_availability_zones.available.names, count.index)}"
  count                       = "${length(data.aws_availability_zones.available.names)}"
  instance_type               = "t2.micro"
  user_data                   = "${file("user_data.sh")}"

  # references security group created above
  vpc_security_group_ids = [
    "${aws_security_group.splice_demo_ec2.id}",
  ]

  tags {
    Name = "Splice Demo ${count.index}"
  }
}
