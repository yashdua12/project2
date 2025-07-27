resource "aws_ami_from_instance" "ec2_image" {      #crearing ami from the ec2_by_terrafrom instance
  name               = "ec2_by_terraform_image"           #name of my ami
  source_instance_id = aws_instance.ec2_by_terraform.id    #giving reference to my instance created before
  description        = "An AMI image created from ec2_by_terraform instance"
  depends_on         = [aws_instance.ec2_by_terraform]  
}
