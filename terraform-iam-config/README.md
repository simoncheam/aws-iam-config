# AWS IAM Configuration

This directory contains the Terraform configuration for managing AWS IAM resources.

## Table of Contents

- [Directory Structure](#directory-structure)
- [Configure AWS Provider](#step-2-configure-aws-provider)
- [Define Input Variables](#step-3-define-input-variables)
- [Create IAM Groups](#step-4-create-iam-groups)
- [Create IAM Policies](#step-5-create-iam-policies)
- [Attach Policies to Groups](#step-6-attach-policies-to-groups)
- [Configure Password Policy](#step-7-configure-password-policy)
- [Create MFA Enforcement Policy](#step-8-create-mfa-enforcement-policy)
- [Main Configuration File](#step-9-main-configuration-file)
- [Apply the Configuration](#step-10-apply-the-configuration)

## Directory Structure

```bash
aws-iam-config/
├── main.tf # Main configuration
├── variables.tf # Input variables
├── outputs.tf # Output values
├── providers.tf # AWS provider configuration
├── groups/ # IAM groups configuration
│ ├── developers.tf
│ ├── operations.tf
│ ├── finance.tf
│ └── analysts.tf
├── policies/ # IAM policies
│ ├── developer_policies.tf
│ ├── operations_policies.tf
│ ├── finance_policies.tf
│ └── analyst_policies.tf
└── security/ # Security settings
├── password_policy.tf
└── mfa_policy.tf
```

## Step 2: Configure AWS Provider

```ts

# providers.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "aws" {
  region = var.aws_region
}
```

## Step 3: Define Input Variables

```ts
# variables.tf

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "production"
}
```

## Step 4: Create IAM Groups

```ts
//  groups/developers.tf

resource "aws_iam_group" "developers" {
  name = "${var.environment}-developers"
  path = "/groups/"
}

# Similar files for other groups...

```

## Step 5: Create IAM Policies

```ts
// policies/developer_policies.tf
resource "aws_iam_policy" "developer_ec2_access" {
  name        = "${var.environment}-DeveloperEC2Access"
  description = "Allows developers to manage EC2 instances"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:Describe*",
          "ec2:RunInstances",
          "ec2:StartInstances",
          "ec2:StopInstances"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "developer_s3_access" {
  name        = "${var.environment}-DeveloperS3Access"
  description = "Allows developers to access application files in S3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::app-files-bucket*",
          "arn:aws:s3:::app-files-bucket*/*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "cloudwatch_read_access" {
  name        = "${var.environment}-CloudWatchReadAccess"
  description = "Allows viewing CloudWatch logs and metrics"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "cloudwatch:Get*",
          "cloudwatch:List*",
          "logs:Get*",
          "logs:List*",
          "logs:StartQuery",
          "logs:StopQuery",
          "logs:Describe*"
        ]
        Resource = "*"
      }
    ]
  })
}

# Similar files for other policies...
```

## Step 6: Attach Policies to Groups

```ts
//  This would go in groups/developers.tf

resource "aws_iam_group_policy_attachment" "developer_ec2_policy" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.developer_ec2_access.arn
}

resource "aws_iam_group_policy_attachment" "developer_s3_policy" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.developer_s3_access.arn
}

resource "aws_iam_group_policy_attachment" "developer_cloudwatch_policy" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.cloudwatch_read_access.arn
}

# Similar attachments for other groups...
```

## Step 7: Configure Password Policy

```ts
// security/password_policy.tf
resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 12
  require_lowercase_characters   = true
  require_uppercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  allow_users_to_change_password = true
  max_password_age               = 90
  password_reuse_prevention      = 5
}
```

## Step 8: Create MFA Enforcement Policy

```ts
// security/mfa_policy.tf
resource "aws_iam_policy" "require_mfa" {
  name        = "RequireMFA"
  description = "Policy that enforces MFA for all users"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowViewAccountInfo"
        Effect = "Allow"
        Action = [
          "iam:GetAccountPasswordPolicy",
          "iam:GetAccountSummary",
          "iam:ListVirtualMFADevices"
        ]
        Resource = "*"
      },
      {
        Sid    = "AllowManageOwnVirtualMFADevice"
        Effect = "Allow"
        Action = [
          "iam:CreateVirtualMFADevice",
          "iam:DeleteVirtualMFADevice"
        ]
        Resource = "arn:aws:iam::*:mfa/$${aws:username}"
      },
      {
        Sid    = "AllowManageOwnUserMFA"
        Effect = "Allow"
        Action = [
          "iam:DeactivateMFADevice",
          "iam:EnableMFADevice",
          "iam:ListMFADevices",
          "iam:ResyncMFADevice"
        ]
        Resource = "arn:aws:iam::*:user/$${aws:username}"
      },
      {
        Sid       = "DenyAllExceptListedIfNoMFA"
        Effect    = "Deny"
        NotAction = [
          "iam:CreateVirtualMFADevice",
          "iam:EnableMFADevice",
          "iam:GetUser",
          "iam:ListMFADevices",
          "iam:ListVirtualMFADevices",
          "iam:ResyncMFADevice",
          "sts:GetSessionToken"
        ]
        Resource  = "*"
        Condition = {
          BoolIfExists = {
            "aws:MultiFactorAuthPresent" = "false"
          }
        }
      }
    ]
  })
}

# Attach to all groups
resource "aws_iam_group_policy_attachment" "developers_require_mfa" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.require_mfa.arn
}

# Similar attachments for other groups...

```

## Step 9: Main Configuration File

```ts
// # main.tf
// # This file can be used to tie everything together
// # or to create example users

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
  groups = [aws_iam_group.developers.name]
}

# Add more users as needed


```

## Step 10: Apply the Configuration

```bash
# Initialize Terraform
terraform init

# Validate the configuration
terraform validate

# Plan the changes
terraform plan -out=tfplan

# Apply the changes
terraform apply tfplan
```
