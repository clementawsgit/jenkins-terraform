terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>5.0"
    }
  }
}

#defining aws provider
provider aws {
    region = "us-east-1"
    access_key = "AKIAWCZC5ZCVTGSUQC2E"
    secret_key = "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"
}

#defining ec2 machine
resource aws_instance "myec" {
    ami = "ami-0c02fb55956c7d316"
    instance_type = "t2.micro"
    key_name = "ubuntu"
    tags = {
        Name = "clement-vm"
    }
}

#defining vpc
resource aws_vpc "myvpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "clementvpc"
    }
}

#defining s3 bucket
resource aws_s3_bucket "mys3bucket" {
    bucket = "singapore1405bkt"
}

#defining security group
resource aws_security_group "allow_ssh" {
    name = "allow_ssh"
    description = "allows incoming ssh traffic"
    vpc_id = "vpc-083bd5085ee1b2149"

    ingress {
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "clem-ssh-sg"
    }
}
