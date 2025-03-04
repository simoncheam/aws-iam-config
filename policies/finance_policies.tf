# policies/finance_policies.tf
# IAM policies for finance team members

resource "aws_iam_policy" "finance_cost_explorer_access" {
  name        = "${var.environment}-FinanceCostExplorerAccess"
  description = "Allows finance team to access cost data"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ce:*", # Cost Explorer full access
          "cur:DescribeReportDefinitions",
          "cur:GetUsageReport"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "finance_billing_access" {
  name        = "${var.environment}-FinanceBillingAccess"
  description = "Allows finance team to access billing information"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "aws-portal:ViewBilling",
          "aws-portal:ViewUsage",
          "budgets:ViewBudget",
          "budgets:DescribeBudgetAction"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "finance_reports_s3_access" {
  name        = "${var.environment}-FinanceReportsS3Access"
  description = "Allows finance team to access financial reports in S3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        # Restrict to finance-specific buckets only
        Resource = [
          "arn:aws:s3:::finance-reports-*",
          "arn:aws:s3:::finance-reports-*/*"
        ]
      }
    ]
  })
}
