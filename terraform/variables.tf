variable "aws_region" {
  description = "AWS region koji se koristi za procenu troškova."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Naziv projekta koji se koristi u tagovima resursa."
  type        = string
  default     = "cloud-cost-optimization"
}

variable "ami_id" {
  description = "AMI ID za EC2 instance. U ovom projektu se koristi kao primer za procenu troškova."
  type        = string
  default     = "ami-12345678"
}

variable "app_instance_type" {
  description = "Tip EC2 instance za aplikacioni server."
  type        = string
  default     = "t4g.small"
}

variable "worker_instance_type" {
  description = "Tip EC2 instance za worker server."
  type        = string
  default     = "t4g.medium"
}

variable "environment" {
  description = "Environment tag (Dev/Stage/Prod)."
  type        = string
  default     = "Dev"
}