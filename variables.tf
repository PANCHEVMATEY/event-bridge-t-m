variable "aws_region" {
  type        = string
  description = "Region for AWS Resources"
  default     = "eu-west-1"
}

variable "policy_arn_Admin_Access" {
  default = "arn:aws:iam::aws:policy/AdministratorAccess"
}