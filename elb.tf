# # # elb.tf # # #

# Security Group for load balancer

resource "aws_security_group" "splice_demo" {
  name = "Splice-Demo-ELB-SG"

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

# Note: this uses the old Classic load balancer rather than
# the more modern (and more complex) Application load balancer.

resource "aws_elb" "splice_demo" {
  name                      = "Splice-Demo-ELB"
  cross_zone_load_balancing = true

  availability_zones = [
    "${aws_instance.splice_demo.*.availability_zone}",
  ]

  # short interval and threshold values reduce the time for instances to become "healthy"
  health_check {
    unhealthy_threshold = 2
    healthy_threshold   = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 20
  }

  instances = [
    "${aws_instance.splice_demo.*.id}",
  ]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  security_groups = [
    "${aws_security_group.splice_demo.id}",
  ]
}
