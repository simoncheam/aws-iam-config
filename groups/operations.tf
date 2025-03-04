
# operations.tf
variable "environment" {
  type        = string
  description = "Environment name (e.g. dev, staging, prod)"
}


resource "aws_iam_group" "operations" {
  name = "${var.environment}-operations"
  path = "/groups/"
}


