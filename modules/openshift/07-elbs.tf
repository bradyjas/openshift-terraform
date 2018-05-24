#### Elastic Load Balancers (ELBs) ####

# TODO: SSL Cert for Master ELB

# Master Console
resource "aws_elb" "master_console" {
  name                        = "osp_master_console"
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  subnets = [
    "${aws_subnet.private1.id}",
    "${aws_subnet.private2.id}",
    "${aws_subnet.private3.id}",
  ]

  security_groups = [
    "${aws_security_group.allow_local_vpc.id}",
  ]

  listener {
    instance_port = 443
    instance_port = "HTTPS"
    lb_port       = 443
    lb_protocol   = "HTTPS"

    #ssl_certificate_id = "arn"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTPS:443/"
    interval            = 30
  }

  tags {
    Name = "osp_master_console"
  }
}

# Nodes
resource "aws_elb" "nodes" {
  name                        = "osp_nodes"
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  subnets = [
    "${aws_subnet.private1.id}",
    "${aws_subnet.private2.id}",
    "${aws_subnet.private3.id}",
  ]

  security_groups = [
    "${aws_security_group.allow_local_vpc.id}",
  ]

  listener {
    instance_port = 443
    instance_port = "HTTPS"
    lb_port       = 443
    lb_protocol   = "HTTPS"

    #ssl_certificate_id = "arn"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTPS:443/"
    interval            = 30
  }

  tags {
    Name = "osp_nodes"
  }
}
