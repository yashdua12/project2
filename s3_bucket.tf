provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "s3-by-terraform-yash01"  
  force_destroy = true  

  tags = {
    Name        = "my_bucket"
    Environment = "dev"
  }
}
