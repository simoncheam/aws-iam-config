# security/password_policy.tf
resource "aws_iam_account_password_policy" "strict" {
  count = var.enable_password_policy ? 1 : 0

  minimum_password_length        = 12
  require_lowercase_characters   = true
  require_uppercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  allow_users_to_change_password = true
  max_password_age               = 90
  password_reuse_prevention      = 5
}