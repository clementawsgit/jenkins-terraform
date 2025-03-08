provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-04b4f1a9cf54c11d0"
  instance_type = "t2.micro"

  tags = {
    Name = "Jenkins-Deployed-EC2"
  }

  key_name = "ubuntu"

  vpc_security_group_ids = ["sg-062d44a4c696a86f2"]
}

output "public_ip" {
  value = aws_instance.example.public_ip
}
