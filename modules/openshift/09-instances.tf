#### EC2 Instances ####

# TODO: User Data for Bastion instance

# Key Pair
resource "aws_key_pair" "openshift" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.key_path)}"
}

## Instances

# Bastion
resource "aws_instance" "bastion" {
  ami                  = "${data.aws_ami.centos7.id}"
  instance_type        = "${var.instance_type.bastion}"
  key_name             = "${aws_key_pair.keypair.key_name}"
  subnet_id            = "${aws_subnet.public1.id}"
  iam_instance_profile = "${aws_iam_instance_profile.bastion.id}"

  #user_data            = "${data.template_file.user_data_bastion.rendered}"

  vpc_security_group_ids = [
    "${aws_security_group.allow_local_vpc.id}",
    "${aws_security_group.allow_in_public_ssh.id}",
    "${aws_security_group.allow_out_public_http-https.id}",
  ]
  root_block_device {
    volume_size = 20
    volume_type = "gp2"
  }
  tags {
    Name = "OpenShift Bastion"
  }
}
