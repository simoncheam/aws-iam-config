# policies/outputs.tf
# Exposes policy ARNs grouped by team so the groups module can attach them.
# Maps use static keys, which lets the groups module for_each over them before the ARNs are known.

output "developer_policy_arns" {
  description = "Scoped policies for the developers group"
  value = {
    ec2        = aws_iam_policy.developer_ec2_access.arn
    s3         = aws_iam_policy.developer_s3_access.arn
    cloudwatch = aws_iam_policy.cloudwatch_read_access.arn
  }
}

output "analyst_policy_arns" {
  description = "Scoped policies for the analysts group"
  value = {
    s3         = aws_iam_policy.analyst_s3_read_access.arn
    athena     = aws_iam_policy.analyst_athena_access.arn
    cloudwatch = aws_iam_policy.analyst_cloudwatch_read_access.arn
  }
}

output "finance_policy_arns" {
  description = "Scoped policies for the finance group"
  value = {
    cost_explorer = aws_iam_policy.finance_cost_explorer_access.arn
    billing       = aws_iam_policy.finance_billing_access.arn
    reports_s3    = aws_iam_policy.finance_reports_s3_access.arn
  }
}

output "operations_policy_arns" {
  description = "Service-scoped policies for the operations group"
  value = {
    ec2           = aws_iam_policy.operations_ec2_full_access.arn
    cloudwatch    = aws_iam_policy.operations_cloudwatch_full_access.arn
    load_balancer = aws_iam_policy.operations_loadbalancer_access.arn
    ssm           = aws_iam_policy.operations_ssm_access.arn
  }
}
