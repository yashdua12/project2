provider "aws" {
  region = "us-east-1"  #this sg uses us -east -1 
}

data "aws_vpc" "default" {
  default = true     # this sg uses defualt vpc 
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Allow SSH from my IP, HTTP from anywhere"
  vpc_id      = data.aws_vpc.default.id

# rule for allowing ssh from myip  
  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["your ip find it from browser by searching find my ip and paste here"]  
  }

# inbound rule for allowing http tarffic from any ipv4
  ingress {
    description = "HTTP access from IPv4"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

# inbound rules for allowing http traffic from any ipv6
  ingress {
    description = "HTTP access from IPv6"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }
# outbound rule to allow all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "ec2_sg" #name of the sg
  }
}
