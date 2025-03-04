output "developers_group_name" {
  value       = module.groups.developers_group_name
  description = "The name of the developers IAM group"
}

output "analysts_group_name" {
  value       = module.groups.analysts_group_name
  description = "The name of the analysts IAM group"
}

output "operations_group_name" {
  value       = module.groups.operations_group_name
  description = "The name of the operations IAM group"
}

output "finance_group_name" {
  value       = module.groups.finance_group_name
  description = "The name of the finance IAM group"
}
