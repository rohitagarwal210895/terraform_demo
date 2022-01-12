
data "aws_availability_zones" "all" {
  all_availability_zones = true
}

# Create autoscaling policy 

resource "aws_autoscaling_policy" "Demo-asg-policy-1" {
  name                   = var.asg_policy_name
  policy_type            = "TargetTrackingScaling"
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.Demo-asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = var.target_value
  }
}

# Create an autoscaling group
resource "aws_autoscaling_group" "Demo-asg" {
  name                 = var.asg_name
  launch_configuration = aws_launch_configuration.Demo-lc.id
  availability_zones   = [data.aws_availability_zones.all.names[0], data.aws_availability_zones.all.names[1]]

  min_size = var.min_size
  max_size = var.max_size

  load_balancers    = [aws_elb.Demo-elb.name]
  health_check_type = "ELB"

  tag {
    key                 = "Name"
    value               = "Demo-ASG"
    propagate_at_launch = true
  }
}

# Create launch configuration
resource "aws_launch_configuration" "Demo-lc" {
  name            = var.launch_config_name
  image_id        = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.Demo-lc-sg.id]

  #iam_instance_profile = var.iam_instance_profile

  user_data = <<EOF
#!/bin/bash
sudo su
yum update -y
yum install httpd -y
service httpd start
echo -e "<h1> Hello ANZ Team, Welcome to Terraform & CodeFresh Demo <h1>" > /var/www/html/index.html
EOF

  lifecycle {
    create_before_destroy = true
  }
}

# Create the ELB
resource "aws_elb" "Demo-elb" {
  name               = var.elb_name
  security_groups    = [aws_security_group.Demo-elb-sg.id]
  availability_zones = [data.aws_availability_zones.all.names[0], data.aws_availability_zones.all.names[1]]
  health_check {
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = 5
    interval            = 30
    target              = "HTTP:${var.server_port}/index.html"
  }

  # This adds a listener for incoming HTTP requests.
  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = var.server_port
    instance_protocol = "http"
  }
}

# Create security group that's applied the launch configuration
resource "aws_security_group" "Demo-lc-sg" {
  name = var.launch_config_sg_name
  # Inbound HTTP from anywhere
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create security group that's applied to the ELB
resource "aws_security_group" "Demo-elb-sg" {
  name = "Demo-elb-sg"

  # Allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound HTTP from anywhere
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

