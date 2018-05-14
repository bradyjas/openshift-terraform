### DNS (Route 53) ###
# Public Zone
# resource "aws_route53_zone" "public" {
#   name              = "${var.domain_name}"
#   delegation_set_id = {}
#   tags {
#     Name = "OpenShift Public DNS"
#   }
# }
# Private Hosted Zone for Amazon VPC
# resource "aws_route53_zone" "private" {
#   name   = "${var.domain_name}"
#   vpc_id = "${aws_vpc.openshift.id}"
#   tags {
#     Name = "OpenShift Private DNS"
#   }
# }
# Public Zone Records
# resource "aws_route53_record" "bastion" {
#   zone_id = "${aws_route53_zone.public.zone_id}"
#   name    = "bastion.${var.domain_name}"
#   type    = "A"
#   ttl     = 300
#   records = ["${aws_instance.bastion.public_ip}"]
# }
# resource "aws_route53_record" "console" {
#   zone_id = "${aws_route53_zone.public.zone_id}"
#   name    = "console.${var.domain_name}"
#   type    = "A"
#   ttl     = 300
#   records = ["${aws_elb.master.public_ip}"]
# }

