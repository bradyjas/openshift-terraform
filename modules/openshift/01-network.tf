#### Networking ####

# VPC
resource "aws_vpc" "openshift" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "OpenShift VPC"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "openshift" {
  vpc_id = "${aws_vpc.openshift.id}"

  tags {
    Name = "OpenShift IGW"
  }
}

# Public Subnets
resource "aws_subnet" "public1" {
  vpc_id                  = "${aws_vpc.openshift.id}"
  cidr_block              = "${var.subnet_cidrs["public1"]}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "OpenShift Public Subnet 1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id                  = "${aws_vpc.openshift.id}"
  cidr_block              = "${var.subnet_cidrs["public2"]}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[1]}"

  tags {
    Name = "OpenShift Public Subnet 2"
  }
}

resource "aws_subnet" "public3" {
  vpc_id                  = "${aws_vpc.openshift.id}"
  cidr_block              = "${var.subnet_cidrs["public3"]}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[2]}"

  tags {
    Name = "OpenShift Public Subnet 3"
  }
}

# Private Subnets
resource "aws_subnet" "private1" {
  vpc_id                  = "${aws_vpc.openshift.id}"
  cidr_block              = "${var.subnet_cidrs["private1"]}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "OpenShift Private Subnet 1"
  }
}

resource "aws_subnet" "private2" {
  vpc_id                  = "${aws_vpc.openshift.id}"
  cidr_block              = "${var.subnet_cidrs["private2"]}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[1]}"

  tags {
    Name = "OpenShift Private Subnet 2"
  }
}

resource "aws_subnet" "private3" {
  vpc_id                  = "${aws_vpc.openshift.id}"
  cidr_block              = "${var.subnet_cidrs["private3"]}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[2]}"

  tags {
    Name = "OpenShift Private Subnet 3"
  }
}

# Default Route Table
resource "aws_default_route_table" "default" {
  default_route_table_id = "${aws_vpc.openshift.default_route_table_id}"

  tags {
    Name = "OpenShift Default Route Table"
  }
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.openshift.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.openshift.id}"
  }

  tags {
    Name = "OpenShift Public Route Table"
  }
}

# Route Table Associations
resource "aws_route_table_association" "public1" {
  subnet_id      = "${aws_subnet.public1.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "public2" {
  subnet_id      = "${aws_subnet.public2.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "public3" {
  subnet_id      = "${aws_subnet.public3.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private1" {
  subnet_id      = "${aws_subnet.private1.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private2" {
  subnet_id      = "${aws_subnet.private2.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private3" {
  subnet_id      = "${aws_subnet.private3.id}"
  route_table_id = "${aws_route_table.public.id}"
}
