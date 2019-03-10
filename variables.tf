variable "aws_profile" {
    description = "The AWS profile local name to use to access the AWS environment."
}

variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

# NB!!!!!!!!!!!
# The configuration is used only during AWS configuration by Terraform.
# The sshd configuration (in user_data launch configuration) does not implemented.
variable "open_port" {
  description = "The port number that should be translated through ELB to the ASG instances."
  default     = "22"
}

# ubuntu-trusty-14.04 (x64)
variable "aws_amis" {
  default = {
    "us-east-1" = "ami-5f709f34"
  }
}

variable "availability_zones" {
  default     = "us-east-1b,us-east-1c,us-east-1d,us-east-1e"
  description = "List of availability zones, use AWS CLI to find your "
}

variable "key_name" {
  description = "Name of AWS key pair"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "AWS instance type"
}

variable "asg_min" {
  description = "Min numbers of servers in ASG"
  default     = "1"
}

variable "asg_max" {
  description = "Max numbers of servers in ASG"
  default     = "2"
}

variable "asg_desired" {
  description = "Desired numbers of servers in ASG"
  default     = "1"
}
