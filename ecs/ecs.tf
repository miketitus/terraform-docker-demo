# # # ecs.tf # # #

resource "aws_ecs_cluster" "splice_demo" {
  name = "Splice-Demo-Cluster"
}

resource "aws_ecs_task_definition" "splice_demo" {
  family = "nginx"

  container_definitions = <<DEFINITION
[
  {
    "cpu": 128,
    "portMappings": [{
        "containerPort": 80,
        "hostPort": 80,
        "protocol": "tcp"
    }],
    "essential": true,
    "image": "nginx:latest",
    "memory": 128,
    "memoryReservation": 64,
    "name": "nginx"
  }
]
DEFINITION
}

resource "aws_ecs_service" "splice_demo" {
  name            = "Splice-Demo-Service"
  cluster         = "${aws_ecs_cluster.splice_demo.id}"
  task_definition = "${aws_ecs_task_definition.splice_demo.arn}"
  desired_count   = "${length(data.aws_availability_zones.available.names)}"

  load_balancer {
    elb_name       = "${aws_elb.splice_demo.id}"
    container_name = "nginx"
    container_port = 80
  }

  placement_strategy {
    type  = "spread"
    field = "host"
  }
}

resource "aws_security_group" "splice_demo_ecs" {
  name        = "Splice-Demo-ECS-SG"
  description = "Allows incoming HTTP traffic only"

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "splice_demo" {
  key_name   = "splice-demo-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDTpWlB2GQxjuaZzdr5RvhyMLE0fIdXf61U3YnotT3L3RK16D9LnLsFpnM9NUmBIQ0uCg+dErp54l5htwm8Wb1qURRbWXYq9Yc9hlUDqIvW3/z3vdGkwb2BSUYvx/5mtGFQZZWorgtuT0r3vBW0KJG3Qu1TCJwyQ20ksCHFYy4jlT/kH+HjodeSK810WNm07+pc5mfnEsgMkL+XZOydZYUy9V27Q2b492IFG+uwfIVH+yJTvs2rlV/7gzT9mTK76kDTzub0X3jNDXZMP1lOIcIP9AszDQ6+RdKZ7GXv2a243LoeQQ6YJJbhAUvQDzktZDvEhcjUzNWYNvAhS9HfrfXD"
}

resource "aws_autoscaling_group" "splice_demo" {
  availability_zones   = ["${data.aws_availability_zones.available.names}"]
  name                 = "${var.ecs_cluster_name}"
  min_size             = 3
  max_size             = 3
  desired_capacity     = 3
  health_check_type    = "EC2"
  launch_configuration = "${aws_launch_configuration.splice_demo.name}"
}

resource "aws_launch_configuration" "splice_demo" {
  name            = "${var.ecs_cluster_name}"
  image_id        = "ami-baa236c2"
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.splice_demo_elb.id}"]
  user_data       = "#!/bin/bash\necho ECS_CLUSTER='${var.ecs_cluster_name}' > /etc/ecs/ecs.config"
}
