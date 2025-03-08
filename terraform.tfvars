# terraform.tfvars

# AWS Configuration
aws_region            = "us-east-1"
instance_type         = "t2.micro"
ami_id                = "ami-04b4f1a9cf54c11d0"
key_name              = "ubuntu"
security_group_ids    = ["sg-062d44a4c696a86f2"] 
subnet_id             = "subnet-017854fdc4ba050f7"

# EC2 Instance Configuration
instance_name         = "jenkins-ec2"
instance_count        = 1
root_volume_size      = 20 # GB

# Optional Tags
tags = {
  Name        = "Jenkins Server"
  Environment = "dev"
  Project     = "CI/CD"
  Owner       = "clement"
}

# Networking ports allowed.
allowed_ports = [22, 80, 443, 8080] # SSH, HTTP, HTTPS, Jenkins
