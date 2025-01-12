# IAM Role
resource "aws_iam_role" "webservice_role" {
  name = "${var.env_name}-webservice-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = { Service = "ec2.amazonaws.com" },
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

# IAM Policy for EC2 Role
resource "aws_iam_policy" "webservice_policy" {
  name        = "${var.env_name}-webservice-policy"
  description = "Policy for webservice to access necessary AWS resources"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "s3:ListBucket",
          "s3:GetObject",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}

# Attach Policy to Role
resource "aws_iam_role_policy_attachment" "webservice_policy_attachment" {
  role       = aws_iam_role.webservice_role.name
  policy_arn = aws_iam_policy.webservice_policy.arn
}

# Instance Profile
resource "aws_iam_instance_profile" "webservice_instance_profile" {
  name = "${var.env_name}-webservice-instance-profile"
  role = aws_iam_role.webservice_role.name
}