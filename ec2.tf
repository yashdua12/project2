provider "aws" {
  region = "us-east-1" #using us-east-1 region 
}

data "aws_vpc" "default" {
  default = true      #using defualt vpc
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id  #using defualt subnets
}

resource "aws_instance" "ec2_by_terraform" {
  ami           = "ami-053b0d53c279acc90"   #ubuntu ami id   
  instance_type = "t2.micro"              #ec2 instance type t2.micro free tier eligble
  key_name      = "kp_terra"

  subnet_id              = data.aws_subnet_ids.default.ids[0]
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
# in advance configuration i have given some basic commands like installing dependenicies
   user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y apache2 unzip zip
              EOF

  tags = {
    Name = "ec2_by_terraform"   #name of the ec2 instance
  }
}
