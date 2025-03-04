# example
# # groups/developers.tf
# variable "environment" {
#   type        = string
#   description = "Environment name (e.g. dev, staging, prod)"
# }

# resource "aws_iam_group" "developers" {
#   name = "${var.environment}-developers"
#   path = "/groups/"
# }

# analysts.tf
variable "environment" {
  type        = string
  description = "Environment name (e.g. dev, staging, prod)"
}

resource "aws_iam_group" "analysts" {
  name = "${var.environment}-analysts"
  path = "/groups/"
}

# Policy attachments for analysts group
resource "aws_iam_group_policy_attachment" "analyst_s3_readonly_policy" {
  group      = aws_iam_group.analysts.name
  policy_arn = aws_iam_policy.analyst_s3_readonly_access.arn
}

resource "aws_iam_group_policy_attachment" "analyst_athena_policy" {
  group      = aws_iam_group.analysts.name
  policy_arn = aws_iam_policy.analyst_athena_access.arn
}

resource "aws_iam_group_policy_attachment" "analyst_quicksight_policy" {
  group      = aws_iam_group.analysts.name
  policy_arn = aws_iam_policy.analyst_quicksight_access.arn
}

resource "aws_iam_group_policy_attachment" "analyst_cloudwatch_policy" {
  group      = aws_iam_group.analysts.name
  policy_arn = aws_iam_policy.cloudwatch_read_access.arn
}


