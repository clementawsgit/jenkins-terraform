terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_instance" "example" {
  ami           = "ami-04b4f1a9cf54c11d0" 
  instance_type = "t2.micro"
  key_name      = "ubuntu"           
  subnet_id     = "subnet-0a712a1d6eccb2d5c"  
  vpc_security_group_ids = [
    "sg-062d44a4c696a86f2", 
  ]

  tags = {
    Name        = "Demo-server"
    Environment = "Development"
  }
}

output "public_ip" {
  value = aws_instance.example.public_ip
}

output "instance_id" {
  value = aws_instance.example.id
}
