variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "production"  # Default value can be omitted if passed from root module
}