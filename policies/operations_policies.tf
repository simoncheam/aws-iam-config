# policies/operations_policies.tf
# IAM policies for operations team members

resource "aws_iam_policy" "operations_ec2_full_access" {
  name        = "${var.environment}-OperationsEC2FullAccess"
  description = "Allows operations team to fully manage EC2 resources"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:*" # Full EC2 access for infrastructure management
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "operations_cloudwatch_full_access" {
  name        = "${var.environment}-OperationsCloudWatchFullAccess"
  description = "Allows operations team to manage CloudWatch resources"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "cloudwatch:*",
          "logs:*",
          "events:*"
        ]
        # Full access to monitoring services for operational visibility
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "operations_loadbalancer_access" {
  name        = "${var.environment}-OperationsLoadBalancerAccess"
  description = "Allows operations team to manage load balancers"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "elasticloadbalancing:*",
          "elasticloadbalancing:Describe*"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "operations_ssm_access" {
  name        = "${var.environment}-OperationsSSMAccess"
  description = "Allows operations team to use Systems Manager"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssm:*" # Systems Manager for instance management and patching
        ]
        Resource = "*"
      }
    ]
  })
}
