# finance.tf
variable "environment" {
  type        = string
  description = "Environment name (e.g. dev, staging, prod)"
}

resource "aws_iam_group" "finance" {
  name = "${var.environment}-finance"
  path = "/groups/"
}


# example
# # groups/developers.tf
# variable "environment" {
#   type        = string
#   description = "Environment name (e.g. dev, staging, prod)"
# }

