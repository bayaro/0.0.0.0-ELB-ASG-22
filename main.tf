# Specify the provider and access details
provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
}

resource "aws_elb" "web-elb" {
  name = "terraform-example-elb"

  # The same availability zone as our instances
  availability_zones = ["${split(",", var.availability_zones)}"]

  listener {
    instance_port     = 22
    instance_protocol = "tcp"
    # I don't know who is so cleave, but we can't __create__ classic ELB
    # that translate port other then 25, 80, 443, 465, 587 or 1024~65535 inclusive.
    # But ))) we can change it after creation. So, please toggle commenting of two
    # below lines before first creation and after a first applying return it back.
    lb_port           = 22
    #lb_port           = 443
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:22"
    interval            = 30
  }

  security_groups = ["${aws_security_group.elb_sg.id}"]
}

resource "aws_autoscaling_group" "web-asg" {
  availability_zones   = ["${split(",", var.availability_zones)}"]
  name                 = "terraform-example-asg"
  max_size             = "${var.asg_max}"
  min_size             = "${var.asg_min}"
  desired_capacity     = "${var.asg_desired}"
  force_delete         = true
  launch_configuration = "${aws_launch_configuration.web-lc.name}"
  load_balancers       = ["${aws_elb.web-elb.name}"]

  #vpc_zone_identifier = ["${split(",", var.availability_zones)}"]
  tag {
    key                 = "Name"
    value               = "web-asg"
    propagate_at_launch = "true"
  }
}

resource "aws_launch_configuration" "web-lc" {
  name          = "terraform-example-lc"
  image_id      = "${lookup(var.aws_amis, var.aws_region)}"
  instance_type = "${var.instance_type}"

  security_groups = ["${aws_security_group.asg_sg.id}"]
  user_data       = "${file("userdata.sh")}"
  key_name        = "${var.key_name}"
}

# collect all vpcs
data "aws_vpcs" "all" {}

# collect all subnets from all vpc ids
data "aws_subnet_ids" "all" {
  count = "${length(data.aws_vpcs.all.ids)}"
  vpc_id = "${element(data.aws_vpcs.all.ids, count.index)}"
}

# collect all subnets
data "aws_subnet" "all" {
  count = "${length(data.aws_subnet_ids.all.ids)}"
  id    = "${data.aws_subnet_ids.all.ids[count.index]}"
}

resource "aws_security_group" "asg_sg" {
  name        = "asg_sg"
  description = "the ASG instances access over 22 port from the ELB points"

  # SSH access from ELB nodes only
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${data.aws_subnet.all.*.cidr_block}"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "elb_sg" {
  name        = "elb_sg"
  description = "the ELB points access over 22 port from anywhere"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
