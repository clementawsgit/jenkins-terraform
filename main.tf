provider "aws" {
    region = "us-east-1"  
}

resource "aws_instance" "foo" {
  ami           = "ami-08b5b3a93ed654d19"
  key_name      = "linux"  
  instance_type = "t2.micro"
  subnet_id     = "subnet-0a712a1d6eccb2d5c"
  vpc_security_group_ids = "sg-062d44a4c696a86f2"
  tags = {
      Name = "TF-Instance"
  }
}
