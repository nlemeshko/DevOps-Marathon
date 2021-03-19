resource "aws_instance" "linux-instance" {
  ami           = "ami-009b16df9fcaac611"
  instance_type = "t2.micro"

  subnet_id = aws_subnet.marathon-subnet-public-1.id

  vpc_security_group_ids = [aws_security_group.marathon-all.id]

  key_name = "marathon"

  tags = {
    "Name" = "linux-instance"
  }

  depends_on = [
    aws_db_instance.devops-marathon-rds,
  ]
}