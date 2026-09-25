variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
}

# Policy ARNs come from the policies module (see main.tf), keyed by a short name.
variable "developer_policy_arns" {
  description = "Policy ARNs to attach to the developers group"
  type        = map(string)
}

variable "analyst_policy_arns" {
  description = "Policy ARNs to attach to the analysts group"
  type        = map(string)
}

variable "finance_policy_arns" {
  description = "Policy ARNs to attach to the finance group"
  type        = map(string)
}

variable "operations_policy_arns" {
  description = "Policy ARNs to attach to the operations group"
  type        = map(string)
}
