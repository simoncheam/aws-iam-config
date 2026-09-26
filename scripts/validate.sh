#!/usr/bin/env bash
# Validates the deployed IAM groups with the IAM policy simulator.
# Read-only: simulate-principal-policy evaluates policies without using any credentials of the groups.
# Usage: ./scripts/validate.sh [environment]   (default: dev)

set -uo pipefail

ENV="${1:-dev}"
pass=0
fail=0

group_arn() {
  aws iam get-group --group-name "$1" --query 'Group.Arn' --output text
}

# check <group> <mfa true|false> <action> <resource> <expected: allowed|implicitDeny|explicitDeny>
check() {
  local group="${ENV}-$1" mfa="$2" action="$3" resource="$4" expected="$5" actual
  actual=$(aws iam simulate-principal-policy \
    --policy-source-arn "$(group_arn "$group")" \
    --action-names "$action" \
    --resource-arns "$resource" \
    --context-entries "ContextKeyName=aws:MultiFactorAuthPresent,ContextKeyValues=${mfa},ContextKeyType=boolean" \
    --query 'EvaluationResults[0].EvalDecision' --output text)

  if [[ "$actual" == "$expected" ]]; then
    result="PASS"; pass=$((pass + 1))
  else
    result="FAIL"; fail=$((fail + 1))
  fi
  printf '%-16s mfa=%-5s %-28s %-45s expected=%-12s actual=%-12s %s\n' \
    "$group" "$mfa" "$action" "${resource#arn:aws:s3:::}" "$expected" "$actual" "$result"
}

echo "Policy simulator checks for environment '${ENV}' ($(date -u +%Y-%m-%dT%H:%MZ))"
echo

echo "# In scope: allowed (with MFA)"
check developers true  ec2:StartInstances         '*'                                            allowed
check developers true  s3:GetObject               'arn:aws:s3:::app-files-bucket-demo/report.csv' allowed
check analysts   true  athena:StartQueryExecution '*'                                            allowed
check analysts   true  s3:GetObject               'arn:aws:s3:::analytics-data-sales/jan.parquet' allowed
check finance    true  ce:GetCostAndUsage         '*'                                            allowed
check finance    true  s3:GetObject               'arn:aws:s3:::finance-reports-2026/q3.csv'      allowed
check operations true  ec2:TerminateInstances     '*'                                            allowed
check operations true  ssm:SendCommand            '*'                                            allowed

echo
echo "# Out of scope: denied (with MFA)"
check developers true  s3:GetObject               'arn:aws:s3:::finance-reports-2026/q3.csv'      implicitDeny
check developers true  ec2:TerminateInstances     '*'                                            implicitDeny
check developers true  rds:CreateDBInstance       '*'                                            implicitDeny
check developers true  iam:CreateUser             '*'                                            implicitDeny
check analysts   true  s3:PutObject               'arn:aws:s3:::analytics-data-sales/jan.parquet' implicitDeny
check analysts   true  quicksight:CreateDashboard '*'                                            implicitDeny
check finance    true  s3:GetObject               'arn:aws:s3:::app-files-bucket-demo/report.csv' implicitDeny
check finance    true  ec2:DescribeInstances      '*'                                            implicitDeny
check operations true  rds:CreateDBInstance       '*'                                            implicitDeny
check operations true  s3:GetObject               'arn:aws:s3:::app-files-bucket-demo/report.csv' implicitDeny
check operations true  iam:CreateUser             '*'                                            implicitDeny

echo
echo "# No MFA: RequireMFA denies everything except MFA setup"
check developers false ec2:StartInstances         '*'                                            explicitDeny
check analysts   false athena:StartQueryExecution '*'                                            explicitDeny
check finance    false ce:GetCostAndUsage         '*'                                            explicitDeny
check operations false ec2:TerminateInstances     '*'                                            explicitDeny
check developers false iam:ListVirtualMFADevices  '*'                                            allowed

echo
echo "${pass} passed, ${fail} failed"
[[ "$fail" -eq 0 ]]
