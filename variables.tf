variable "aws_profile" {
  type        = string
  default     = "default"
  description = "AWS profile for credentials"
}

variable "domain_name" {
  type        = string
  description = "Domain name to be used as bucket name. Needs to follow S3 bucket naming conventions"
}
