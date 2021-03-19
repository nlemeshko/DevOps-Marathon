output "rds_endpoint" {
  description = "The address of the RDS instance"
  value       = aws_db_instance.devops-marathon-rds.endpoint
}
output "ec2_endpoint" {
  description = "The address of the EC2 instance"
  value       = aws_instance.linux-instance.public_ip
}
output "base_url" {
  value = aws_api_gateway_deployment.devops-marathon.invoke_url
}