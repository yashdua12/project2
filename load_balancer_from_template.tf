provider "aws" {
  region = "us-east-1"  #region using us-east-1
}


data "aws_vpc" "default" {
  default = true    #uses default vpc 
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id  #uses default subnets
}


resource "aws_lb" "alb_by_terraform" {    #name of load balancer is alb by terrafrom
  name               = "alb-by-terraform"   
  internal           = false
  load_balancer_type = "application"     #type of load balancer is accepts all requests from http and https
  security_groups    = [aws_security_group.ec2_sg.id]  #uses current security group created previously
  subnets            = data.aws_subnet_ids.default.ids

  enable_deletion_protection = false

  tags = {
    Name = "alb_by_terraform"
  }
}


resource "aws_lb_listener" "http_listener" {     #listens requests on port 80 
  load_balancer_arn = aws_lb.alb_by_terraform.arn
  port              = 80                          
  protocol          = "HTTP"

  default_action {          #uses target group for instance or template health check 
    type             = "forward"   
    target_group_arn = aws_lb_target_group.tg_by_terraform.arn   #previously created target group 
  }
}


resource "aws_autoscaling_group" "asg_from_template" {   #autoscaling the templates
  name                      = "asg-from-template"     #autoscaling group name
  max_size                  = 2       # if instance cpu utilization goes above 60% then create a max of 2 instances
  min_size                  = 1       #otherwise keep it 1
  desired_capacity          = 1       # in start deploy only 1
  vpc_zone_identifier       = data.aws_subnet_ids.default.ids
  target_group_arns         = [aws_lb_target_group.tg_by_terraform.arn]
  health_check_type         = "EC2"
  health_check_grace_period = 60   #health check metric 60% or above

  launch_template {
    id      = aws_launch_template.ec2_template.id  #template name through whhich autoscaling will take place
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "ec2_from_template"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
