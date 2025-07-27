provider "aws" {
  region = "us-east-1"  
}

resource "aws_key_pair" "kp_terra" {
  key_name   = "my-key"  
  public_key = file("${path.module}/my-key.pub")  # Load from current folder
}
