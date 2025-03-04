# operations.tf


resource "aws_iam_group" "operations" {
  name = "${var.environment}-operations"
  path = "/groups/"
}

# Policy attachments for operations group
resource "aws_iam_group_policy_attachment" "operations_ec2_policy" {
  group      = aws_iam_group.operations.name
  policy_arn = aws_iam_policy.operations_ec2_access.arn
}

resource "aws_iam_group_policy_attachment" "operations_rds_policy" {
  group      = aws_iam_group.operations.name
  policy_arn = aws_iam_policy.operations_rds_access.arn
}

resource "aws_iam_group_policy_attachment" "operations_s3_policy" {
  group      = aws_iam_group.operations.name
  policy_arn = aws_iam_policy.operations_s3_access.arn
}

resource "aws_iam_group_policy_attachment" "operations_cloudwatch_policy" {
  group      = aws_iam_group.operations.name
  policy_arn = aws_iam_policy.operations_cloudwatch_access.arn
}

resource "aws_iam_group_policy_attachment" "operations_cloudtrail_policy" {
  group      = aws_iam_group.operations.name
  policy_arn = aws_iam_policy.operations_cloudtrail_access.arn
}

resource "aws_iam_group_policy_attachment" "operations_loadbalancer_policy" {
  group      = aws_iam_group.operations.name
  policy_arn = aws_iam_policy.operations_loadbalancer_access.arn
}


