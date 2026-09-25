# groups/developers.tf

resource "aws_iam_group" "developers" {
  name = "${var.environment}-developers"
  path = "/groups/"
}

# Attach every policy passed in from the policies module
resource "aws_iam_group_policy_attachment" "developers" {
  for_each = var.developer_policy_arns

  group      = aws_iam_group.developers.name
  policy_arn = each.value
}
