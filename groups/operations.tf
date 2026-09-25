# groups/operations.tf

resource "aws_iam_group" "operations" {
  name = "${var.environment}-operations"
  path = "/groups/"
}

# Attach every policy passed in from the policies module
resource "aws_iam_group_policy_attachment" "operations" {
  for_each = var.operations_policy_arns

  group      = aws_iam_group.operations.name
  policy_arn = each.value
}
