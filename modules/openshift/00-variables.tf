variable "aws_region" {
  description = "The AWS region to deploy into (Example: us-west-2)"
  default     = "us-west-2"
}

variable "key_name" {
  description = "Name of the key for SSH access (Example: openshift)"
}

variable "key_path" {
  description = "Local path for the SSH key (Example: ~/.ssh/openshift.pub)"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC (Example: 10.10.0.0/16)"
  default     = "10.10.0.0/16"
}

data "aws_availability_zones" "available" {}

variable "subnet_cidrs" {
  description = "CIDR blocks for the subnets (Example: 10.10.11.0/16)"
  type        = "map"

  default = {
    public1  = "10.10.11.0/24"
    public2  = "10.10.12.0/24"
    public3  = "10.10.13.0/24"
    private1 = "10.10.21.0/24"
    private2 = "10.10.22.0/24"
    private3 = "10.10.23.0/24"
  }
}

variable "instance_types" {
  description = "EC2 instance types for the provisioned instances (Example: m5.large)"
  type        = "map"

  default = {
    bastion = "t2.medium"
    master  = "m5.xlarge"
    etcd    = "m2.medium"
    node    = "m5.large"
  }
}
