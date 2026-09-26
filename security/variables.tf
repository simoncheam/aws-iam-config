variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
}

variable "mfa_required_groups" {
  description = "Groups that get the RequireMFA policy, keyed by a short name. Members without an MFA session are denied everything except MFA setup."
  type        = map(string)
}

variable "enable_password_policy" {
  description = "Manage the account-wide IAM password policy. It applies to every IAM user in the account, not just these groups."
  type        = bool
  default     = true
}
