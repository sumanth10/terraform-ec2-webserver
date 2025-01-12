output "ec2_instance_id" {
  description = "ID of the webservice EC2 instance"
  value       = aws_instance.webservice.id
}

output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "Private subnets for the VPC"
  value       = module.vpc.private_subnets
}