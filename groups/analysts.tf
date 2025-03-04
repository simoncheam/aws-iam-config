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


