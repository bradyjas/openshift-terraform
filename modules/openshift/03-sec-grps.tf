#### Security Groups ####

# Allow all local traffic
resource "aws_security_group" "allow_local_vpc" {
  name        = "osp_allow_local_vpc"
  description = "Allow all local VPC traffic"
  vpc_id      = "${aws_vpc.openshift.id}"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  tags {
    Name = "osp_allow_local_vpc"
  }
}

# Allow public ingress for SSH to bastion
resource "aws_security_group" "allow_in_public_ssh" {
  name        = "osp_allow_in_public_ssh"
  description = "Allow in public SSH traffic to bastion"
  vpc_id      = "${aws_vpc.openshift.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "osp_allow_in_public_ssh"
  }
}

# Allow public ingress for HTTP/S to internal
resource "aws_security_group" "allow_in_public_http-https" {
  name        = "osp_allow_in_public_http-https"
  description = "Allow in public HTTP/S traffic to internal"
  vpc_id      = "${aws_vpc.openshift.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "osp_allow_in_public_http-https"
  }
}

# Allow public egress for HTTP/S from internal
resource "aws_security_group" "allow_out_public_http-https" {
  name        = "osp_allow_out_public_http-https"
  description = "Allow out public HTTP/S traffic from internal"
  vpc_id      = "${aws_vpc.openshift.id}"

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "osp_allow_out_public_http-https"
  }
}
