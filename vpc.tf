# one vpc to hold them all, and in the cloud bind them
resource "aws_vpc" "splice_demo" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name = "Splice-Demo-VPC"
  }
}

# let vpc talk to the internet
resource "aws_internet_gateway" "splice_demo" {
  vpc_id = "${aws_vpc.splice_demo.id}"

  tags {
    Name = "Splice-Demo-IGW"
  }
}

# create one subnet per availability zone
resource "aws_subnet" "splice_demo" {
  availability_zone       = "${element(data.aws_availability_zones.available.names, count.index)}"
  cidr_block              = "10.0.${count.index}.0/24"
  count                   = "${length(data.aws_availability_zones.available.names)}"
  map_public_ip_on_launch = true
  vpc_id                  = "${aws_vpc.splice_demo.id}"
}

# dynamic list of subnets created above
data "aws_subnet_ids" "splice_demo" {
  depends_on = ["aws_subnet.splice_demo"]
  vpc_id     = "${aws_vpc.splice_demo.id}"
}

# huh?
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.splice_demo.id}"

  tags {
    Name = "Splice-Public-Route-Table"
  }
}

# add public gateway to public route table
resource "aws_route" "public" {
  gateway_id             = "${aws_internet_gateway.splice_demo.id}"
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = "${aws_route_table.public.id}"
}
