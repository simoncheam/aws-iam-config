# policies/developer_policies.tf
resource "aws_iam_policy" "developer_ec2_access" {
  name        = "${var.environment}-DeveloperEC2Access"
  description = "Allows developers to manage EC2 instances"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:Describe*",
          "ec2:RunInstances",
          "ec2:StartInstances",
          "ec2:StopInstances"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "developer_s3_access" {
  name        = "${var.environment}-DeveloperS3Access"
  description = "Allows developers to access application files in S3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::app-files-bucket*",
          "arn:aws:s3:::app-files-bucket*/*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "cloudwatch_read_access" {
  name        = "${var.environment}-CloudWatchReadAccess"
  description = "Allows viewing CloudWatch logs and metrics"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "cloudwatch:Get*",
          "cloudwatch:List*",
          "logs:Get*",
          "logs:List*",
          "logs:StartQuery",
          "logs:StopQuery",
          "logs:Describe*"
        ]
        Resource = "*"
      }
    ]
  })
}

# Similar files for other policies...