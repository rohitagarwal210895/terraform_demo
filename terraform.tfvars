region                = "us-west-1"
//////
key_name              = "test_demo"
ami_id                = "ami-02d03ce209db75523"
instance_type         = "t2.micro"
target_value          = 70.0
min_size              = 1
max_size              = 3
asg_policy_name       = "demo-asg-policy"
asg_name              = "demo-asg"
elb_name              = "demo-elb"
launch_config_name    = "demo-launch-config"
healthy_threshold     = 2
unhealthy_threshold   = 2
launch_config_sg_name = "demo-ec2-sg"
elb_sg_name           = "demo-elb-sg"
s3_bucket             = "terraform-demo-test"

