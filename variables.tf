variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-2"
}

variable "bucket_name" {
  description = "The name of the S3 bucket to be created"
  type        = string
  default     = "github-oidc-aws-terraform"
}


variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
  default     = "POC_IODC_DEPLOYMENT"
}
