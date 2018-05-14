provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
}

module "openshift" {
  source         = "./modules/openshift"
  aws_region     = "${var.aws_region}"
  key_name       = "${var.key_name}"
  key_path       = "${var.key_path}"
  vpc_cidr       = "${var.vpc_cidr}"
  subnet_cidrs   = "${var.subnet_cidrs}"
  instance_types = "${var.instance_types}"
}
