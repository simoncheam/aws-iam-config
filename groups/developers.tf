# groups/developers.tf


resource "aws_iam_group" "developers" {
  name = "${var.environment}-developers"
  path = "/groups/"
}

# Similar files for other groups...

# This would go in groups/developers.tf
resource "aws_iam_group_policy_attachment" "developer_ec2_policy" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.developer_ec2_access.arn
}

resource "aws_iam_group_policy_attachment" "developer_s3_policy" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.developer_s3_access.arn
}

resource "aws_iam_group_policy_attachment" "developer_cloudwatch_policy" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.cloudwatch_read_access.arn
}

# Similar attachments for other groups...