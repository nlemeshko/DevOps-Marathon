resource "aws_db_instance" "devops-marathon-rds" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = var.db_name
  skip_final_snapshot  = true
  publicly_accessible  = true
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql5.7"

  tags = {
    "Name" = "devops-marathon-rds"
  }
}