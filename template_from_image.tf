resource "aws_launch_template" "ec2_template" {
  name_prefix   = "ec2-template-"  
  image_id      = aws_ami_from_instance.ec2_image.id   #image id is which i created through launching ami from ec2 instance
  instance_type = "t2.micro"  # type is free tier eligible 
  key_name      = "kp_terra"  #using same key pair

  network_interfaces {
    associate_public_ip_address = true           
    security_groups             = [aws_security_group.ec2_sg.id] #using same security group
    subnet_id                   = data.aws_subnet_ids.default.ids[0]  #default vpc
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "ec2_from_template"
    }
  }
}
