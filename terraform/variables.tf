variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project prefix for resources"
  type        = string
  default     = "shopingkaro"
}

variable "ecs_desired_count" {
  type    = number
  default = 1
}

variable "vpc_id" {
  description = "ID of an existing VPC to use for resources"
  type        = string
  default     = ""
}

variable "public_subnet_ids" {
  description = "List of subnet IDs to use for public resources (ALB)"
  type        = list(string)
  default     = []
}

variable "private_subnet_ids" {
  description = "List of subnet IDs to use for private resources (ECS, DB)"
  type        = list(string)
  default     = []
}

variable "acm_certificate_arn" {
  description = "ARN of an existing ACM certificate for the ALB HTTPS listener (must be in the same region)"
  type        = string
  default     = ""
}

variable "docdb_username" {
  description = "Username for DocumentDB admin user"
  type        = string
  sensitive   = true
}

variable "docdb_password" {
  description = "Password for DocumentDB admin user"
  type        = string
  sensitive   = true
}