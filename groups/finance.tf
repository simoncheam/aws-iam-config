# finance.tf

resource "aws_iam_group" "finance" {
  name = "${var.environment}-finance"
  path = "/groups/"
}

# Policy attachments for finance group
resource "aws_iam_group_policy_attachment" "finance_cost_explorer_policy" {
  group      = aws_iam_group.finance.name
  policy_arn = aws_iam_policy.finance_cost_explorer_access.arn
}

resource "aws_iam_group_policy_attachment" "finance_budgets_policy" {
  group      = aws_iam_group.finance.name
  policy_arn = aws_iam_policy.finance_budgets_access.arn
}

resource "aws_iam_group_policy_attachment" "finance_billing_policy" {
  group      = aws_iam_group.finance.name
  policy_arn = aws_iam_policy.finance_billing_access.arn
}

resource "aws_iam_group_policy_attachment" "finance_readonly_policy" {
  group      = aws_iam_group.finance.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}


