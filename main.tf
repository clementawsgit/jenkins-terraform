terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "demovpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "project-vpc"
  }
}

# Create a public subnet
resource "aws_subnet" "demopubsub" {
  vpc_id     = aws_vpc.demovpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a" 
  map_public_ip_on_launch = true 

  tags = {
    Name = "project-pubsub"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "demoigw" {
  vpc_id = aws_vpc.demovpc.id

  tags = {
    Name = "project-igw"
  }
}

# Create a Route Table
resource "aws_route_table" "demopubrt" {
  vpc_id = aws_vpc.demovpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demoigw.id
  }

  tags = {
    Name = "project-pubrt"
  }
}

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "demopubrt-association" {
  subnet_id      = aws_subnet.demopubsub.id
  route_table_id = aws_route_table.demopubrt.id
}

#Example of a Private subnet
resource "aws_subnet" "demoprisub" {
  vpc_id            = aws_vpc.demovpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a" 

  tags = {
    Name = "project-prisub"
  }
}

# Create a NAT gateway and elastic IP
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "project-nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.demopubsub.id 

  tags = {
    Name = "project-nat"
  }
}

#Private Route table
resource "aws_route_table" "demoprirt" {
  vpc_id = aws_vpc.demovpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "project-prirt"
  }
}

#Private Route table association
resource "aws_route_table_association" "demoprirt-association" {
  subnet_id      = aws_subnet.demoprisub.id
  route_table_id = aws_route_table.demoprirt.id
}
