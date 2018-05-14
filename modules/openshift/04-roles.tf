#### IAM Roles ####

## EC2 Instance Roles

# Bastion Role
resource "aws_iam_role" "bastion" {
  name = "osp_bastion"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

# Master Role
resource "aws_iam_role" "master" {
  name = "osp_master"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

# etcd Role
resource "aws_iam_role" "etcd" {
  name = "osp_etcd"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

# Node Role
resource "aws_iam_role" "node" {
  name = "osp_node"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

## Instance Profiles

# Bastion
resource "aws_iam_instance_profile" "bastion" {
  name = "osp_bastion"
  role = "${aws_iam_role.bastion.name}"
}

# Master
resource "aws_iam_instance_profile" "master" {
  name = "osp_master"
  role = "${aws_iam_role.master.name}"
}

# etcd
resource "aws_iam_instance_profile" "etcd" {
  name = "osp_etcd"
  role = "${aws_iam_role.etcd.name}"
}

# Node
resource "aws_iam_instance_profile" "node" {
  name = "osp_node"
  role = "${aws_iam_role.node.name}"
}

## Policies

# Allow CloudWatch Logs Policy
resource "aws_iam_policy" "allow_put_cloudwatch_logs" {
  name        = "osp_allow_put_cloudwatch_logs"
  path        = "/"
  description = "Allow PUTs to CloudWatch Logs"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams"
      ],
      "Resource": [
        "arn:aws:logs:*:*:*"
      ]
    }
  ]
}
EOF
}

## Policy Attachments

# Attach CloudWatch Logs To All Roles
resource "aws_iam_policy_attachment" "attach_cloudwatch_to_roles" {
  name       = "osp_attach_cloudwatch_to_roles"
  policy_arn = "${aws_iam_policy.allow_put_cloudwatch_logs.arn}"

  roles = [
    "${aws_iam_role.master.name}",
    "${aws_iam_role.etcd.name}",
    "${aws_iam_role.node.name}",
    "${aws_iam_role.bastion.name}",
  ]
}

## IAM Users


# TODO: IAM Users


## IAM Access Key


# TODO: IAM Access Key

