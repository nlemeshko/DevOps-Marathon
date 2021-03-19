resource "aws_vpc" "marathon-vpc" {
  cidr_block           = "172.31.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_classiclink   = false
  instance_tenancy     = "default"

  tags = {
    "Name" = "marathon-vpc"
  }
}

resource "aws_subnet" "marathon-subnet-public-1" {
  vpc_id                  = aws_vpc.marathon-vpc.id
  cidr_block              = "172.31.0.0/20"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1a"

  tags = {
    "Name" = "marathon-subnet-public-1"
  }
}


resource "aws_internet_gateway" "marathon-igw" {
  vpc_id = aws_vpc.marathon-vpc.id

  tags = {
    "Name" = "marathon-igw"
  }
}

resource "aws_route_table" "marathon-public-crt" {
  vpc_id = aws_vpc.marathon-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.marathon-igw.id
  }

  tags = {
    Name = "marathon-public-crt"
  }
}

resource "aws_route_table_association" "marathon-crta-public-subnet-1" {
  subnet_id      = aws_subnet.marathon-subnet-public-1.id
  route_table_id = aws_route_table.marathon-public-crt.id
}

resource "aws_security_group" "marathon-all" {
  vpc_id = aws_vpc.marathon-vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 9900
    to_port     = 9900
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "marathon-all"
  }
}