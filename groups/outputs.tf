# This outputs.tf file exposes IAM group names created in this module for reference by other Terraform modules
# Outputs allow other modules to access these values without having to hard-code or redeclare the resources

output "developers_group_name" {
  value       = aws_iam_group.developers.name
  description = "The name of the developers IAM group"
}

# Each output exposes a specific IAM group name, making the group accessible to parent modules
# This enables composition of modules while maintaining proper resource dependencies
output "analysts_group_name" {
  value       = aws_iam_group.analysts.name
  description = "The name of the analysts IAM group"
}

output "operations_group_name" {
  value       = aws_iam_group.operations.name
  description = "The name of the operations IAM group"
}

output "finance_group_name" {
  value       = aws_iam_group.finance.name
  description = "The name of the finance IAM group"
}