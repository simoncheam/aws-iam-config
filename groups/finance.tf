# groups/finance.tf

resource "aws_iam_group" "finance" {
  name = "${var.environment}-finance"
  path = "/groups/"
}

# Attach every policy passed in from the policies module
resource "aws_iam_group_policy_attachment" "finance" {
  for_each = var.finance_policy_arns

  group      = aws_iam_group.finance.name
  policy_arn = each.value
}
