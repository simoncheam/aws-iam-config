# Policies module

Creates the scoped IAM policies for each team. `outputs.tf` exposes their ARNs as one map per team, and the `groups` module attaches them. See the [main README](../README.md) for how the modules connect.

| Team | Policy (`<env>-` prefix) | Actions | Resources |
|---|---|---|---|
| Developers | `DeveloperEC2Access` | `ec2:Describe*`, `RunInstances`, `StartInstances`, `StopInstances` | `*` |
| Developers | `DeveloperS3Access` | `s3:GetObject`, `PutObject`, `ListBucket` | `app-files-bucket*` |
| Developers | `CloudWatchReadAccess` | CloudWatch `Get*`/`List*`; Logs `Get*`/`List*`/`Describe*`, `StartQuery`, `StopQuery` | `*` |
| Analysts | `AnalystS3ReadAccess` | `s3:GetObject`, `ListBucket` | `analytics-data-*`, `data-warehouse-*` |
| Analysts | `AnalystAthenaAccess` | 6 named Athena query actions | `*` |
| Analysts | `AnalystCloudWatchReadAccess` | CloudWatch `Get*`/`List*`/`Describe*` | `*` |
| Finance | `FinanceCostExplorerAccess` | `ce:*`, 2 Cost and Usage Report read actions | `*` |
| Finance | `FinanceBillingAccess` | View billing and usage; view budgets | `*` |
| Finance | `FinanceReportsS3Access` | `s3:GetObject`, `ListBucket` | `finance-reports-*` |
| Operations | `OperationsEC2FullAccess` | `ec2:*` | `*` |
| Operations | `OperationsCloudWatchFullAccess` | `cloudwatch:*`, `logs:*`, `events:*` | `*` |
| Operations | `OperationsLoadBalancerAccess` | `elasticloadbalancing:*` | `*` |
| Operations | `OperationsSSMAccess` | `ssm:*` | `*` |

Developer, analyst, and finance policies list named actions and limit S3 to specific bucket patterns. Operations policies grant full access within each service.
