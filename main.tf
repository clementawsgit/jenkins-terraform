provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-04b4f1a9cf54c11d0" # Replace with your AMI
  instance_type = "t2.micro"
  count = "1"
  tags = {
    Name = "MyInstance"
  }
}
