variable "project_name" {
  description = "Name of the project, used for resource naming"
  type        = string
  default     = "document-processor"
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

variable "create_state_iam_policy" {
  description = "Whether to create the IAM policy for Terraform state access"
  type        = bool
  default     = false
}

variable "state_bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  type        = string
  default     = "terraform-state-bucket-cmos"
}

variable "state_table_name" {
  description = "Name of the DynamoDB table for Terraform state locking"
  type        = string
  default     = "terraform-state-table-cmos"
}

variable "aws_cognito_users" {
  description = "List of Cognito users to create"
  type        = map(string)
  default     = {}
} 
