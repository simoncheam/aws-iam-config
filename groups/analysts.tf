# groups/analysts.tf

resource "aws_iam_group" "analysts" {
  name = "${var.environment}-analysts"
  path = "/groups/"
}

# Attach every policy passed in from the policies module
resource "aws_iam_group_policy_attachment" "analysts" {
  for_each = var.analyst_policy_arns

  group      = aws_iam_group.analysts.name
  policy_arn = each.value
}
