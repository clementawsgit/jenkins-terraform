provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-08b5b3a93ed654d19" # Replace with your AMI
  instance_type = "t2.micro"
  count = "1"
  tags = {
    Name = "MyInstance"
  }
}
