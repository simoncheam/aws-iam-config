module "policies" {
  source      = "./policies"
  environment = var.environment
}

module "groups" {
  source      = "./groups"
  environment = var.environment

  developer_policy_arns  = module.policies.developer_policy_arns
  analyst_policy_arns    = module.policies.analyst_policy_arns
  finance_policy_arns    = module.policies.finance_policy_arns
  operations_policy_arns = module.policies.operations_policy_arns
}


# main.tf
# This file can be used to tie everything together
# or to create example users

resource "aws_iam_user" "example_developer" {
  name = "dev-example"
  path = "/users/"

  # Force MFA setup on first login
  tags = {
    require_mfa = "true"
  }
}

resource "aws_iam_user_group_membership" "example_developer" {
  user   = aws_iam_user.example_developer.name
  groups = [module.groups.developers_group_name]
}

# Add more users as needed