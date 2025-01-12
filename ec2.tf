# Security Group for EC2 Instance
resource "aws_security_group" "webservice_sg" {
  name        = "${var.env_name}-webservice-sg"
  description = "Security group for internal webservice"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # Allow SSH from within the VPC
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # Allow webservice access from within the VPC
  }

  tags = local.tags
}


# EC2 Instance
resource "aws_instance" "webservice" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI
  instance_type = "t3.micro"
  subnet_id     = module.vpc.private_subnets[0]
  security_groups = [
    aws_security_group.webservice_sg.name
  ]
  iam_instance_profile = aws_iam_instance_profile.webservice_instance_profile.name
  tags = {
    Name = "webservice-instance"
  }

  user_data = <<-EOF
    #!/bin/bash
    echo "Webservice instance initialized" > /var/log/webservice-init.log
  EOF
}
