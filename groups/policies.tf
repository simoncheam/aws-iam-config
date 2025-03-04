# Common policies
# These policies are general access controls that might be attached to multiple groups
resource "aws_iam_policy" "cloudwatch_read_access" {
  name        = "${var.environment}-cloudwatch-read-access"
  description = "Allows read access to CloudWatch"
  # Policy provides read-only actions (Get*, List*, Describe*) for CloudWatch metrics and dashboards
  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action   = [
          "cloudwatch:Get*",
          "cloudwatch:List*",
          "cloudwatch:Describe*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# Analyst policies
# These policies grant data analysts the specific permissions needed for their role
# Read-only S3 access helps analysts view data without modifying it
# Full access to Athena and QuickSight allows them to query data and build visualizations
resource "aws_iam_policy" "analyst_s3_readonly_access" {
  name        = "${var.environment}-analyst-s3-readonly-access"
  description = "Allows analysts read access to S3"
  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action   = [
          "s3:Get*",
          "s3:List*",
          "s3:Describe*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "analyst_athena_access" {
  name        = "${var.environment}-analyst-athena-access"
  description = "Allows analysts access to Athena"
  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action   = ["athena:*"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "analyst_quicksight_access" {
  name        = "${var.environment}-analyst-quicksight-access"
  description = "Allows analysts access to QuickSight"
  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action   = ["quicksight:*"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# Developer policies
# These policies provide developers with access to resources needed for application development
# Full access to EC2 instances and S3 buckets for deploying and storing application code/data
resource "aws_iam_policy" "developer_ec2_access" {
  name        = "${var.environment}-developer-ec2-access"
  description = "Allows developers access to EC2"
  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action   = ["ec2:*"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "developer_s3_access" {
  name        = "${var.environment}-developer-s3-access"
  description = "Allows developers access to S3"
  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:*"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# Finance policies
# These policies grant the finance team access to cost management and billing services
# Enables them to monitor spending, set budgets, and access billing information
resource "aws_iam_policy" "finance_cost_explorer_access" {
  name        = "${var.environment}-finance-cost-explorer-access"
  description = "Allows finance access to Cost Explorer"
  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action   = ["ce:*"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "finance_budgets_access" {
  name        = "${var.environment}-finance-budgets-access"
  description = "Allows finance access to Budgets"
  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action   = ["budgets:*"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "finance_billing_access" {
  name        = "${var.environment}-finance-billing-access"
  description = "Allows finance access to Billing"
  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action   = ["billing:*"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# Operations policies
# These policies give the operations team full access to infrastructure management services
# Allows them to provision, monitor, and maintain the AWS environment
# Includes access to EC2, RDS databases, S3 storage, monitoring (CloudWatch),
# auditing (CloudTrail), and load balancers for complete infrastructure oversight
resource "aws_iam_policy" "operations_ec2_access" {
  name        = "${var.environment}-operations-ec2-access"
  description = "Allows operations access to EC2"
  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action   = ["ec2:*"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "operations_rds_access" {
  name        = "${var.environment}-operations-rds-access"
  description = "Allows operations access to RDS"
  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action   = ["rds:*"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "operations_s3_access" {
  name        = "${var.environment}-operations-s3-access"
  description = "Allows operations access to S3"
  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:*"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "operations_cloudwatch_access" {
  name        = "${var.environment}-operations-cloudwatch-access"
  description = "Allows operations access to CloudWatch"
  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action   = ["cloudwatch:*"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "operations_cloudtrail_access" {
  name        = "${var.environment}-operations-cloudtrail-access"
  description = "Allows operations access to CloudTrail"
  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action   = ["cloudtrail:*"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "operations_loadbalancer_access" {
  name        = "${var.environment}-operations-loadbalancer-access"
  description = "Allows operations access to Load Balancers"
  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action   = [
          "elasticloadbalancing:*",
          "elb:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}
