# AWS IAM Infrastructure Documentation

## Executive Summary

This documentation provides an overview of the AWS IAM infrastructure implemented via Terraform. The project provisions a secure IAM foundation with predefined user groups, policies, and roles following AWS best practices and the principle of least privilege.

## Project Structure

### Documentation Organization

- **[Project Root README](../README.md)**: Contains the technical overview and setup instructions
- **[Groups Module](../groups/)**: Contains the IAM group definitions and associated policies
- **This Document**: Provides context and clarification on how the different pieces fit together

## Existing Modules

### Groups

Located in the [`groups/`](../groups/) directory, this module defines standard IAM groups:

- Developers: For engineering team members
- Analysts: For data and business analysts
- Operations: For IT operations staff
- Finance: For finance department users

### Policies

Found in the relevant module directories, these define the permission sets attached to groups and roles.

## Security Approach

The infrastructure follows these security best practices:

- Principle of least privilege through granular permissions
- Separation of duties via distinct user groups
- Resource-based access controls where appropriate

## Getting Started

Refer to the [main README.md](../README.md) in the project root for deployment instructions and prerequisites.
